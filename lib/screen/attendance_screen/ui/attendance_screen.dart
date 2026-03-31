import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util/core/device_id/device_service.dart';
import '../model/today_attendance_model.dart';
import '../provider/attendance_provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    super.initState();
    loadDeviceId();
    restoreShiftAndTimer();
    Provider.of<AttendanceProvider>(
      context,
      listen: false,
    ).getTodayAttendanceDate();
  }

  String deviceId = "";
  bool isPunchedIn = false;
  Timer? _timer;
  Duration _duration = Duration();
  bool _dialogShown = false;

  void loadDeviceId() async {
    String id = await DeviceService.getDeviceId();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceId', id);

    if (mounted) {
      setState(() {
        deviceId = id;
      });
    }
  }

  String get timerText {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void restoreShiftAndTimer() async {
    final prefs = await SharedPreferences.getInstance();
    String? shiftStart = prefs.getString('shiftStart');
    String? shiftEnd = prefs.getString('shiftEnd');
    String? punchTimeStr = prefs.getString('punchTime');
    if (shiftStart == null || shiftEnd == null || punchTimeStr == null) return;
    DateTime punchTime = DateTime.parse(punchTimeStr);
    final now = DateTime.now();
    if (punchTime.year == now.year &&
        punchTime.month == now.month &&
        punchTime.day == now.day) {
      final attendanceProvider = Provider.of<AttendanceProvider>(
        context,
        listen: false,
      );
      attendanceProvider.shiftStart = shiftStart;
      attendanceProvider.shiftEnd = shiftEnd;
      setState(() {
        if (now.isBefore(punchTime)) {
          _duration = Duration.zero;
        } else {
          _duration = now.difference(punchTime);
          startTimer(shiftStart);
        }
      });
    } else {
      prefs.remove('shiftStart');
      prefs.remove('shiftEnd');
      prefs.remove('punchTime');
    }
  }

  String formatTime(String time) {
    try {
      final parts = time.split(":");
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      String period = hour >= 12 ? "PM" : "AM";
      hour = hour % 12 == 0 ? 12 : hour % 12;
      return "$hour:${minute.toString().padLeft(2, '0')} $period";
    } catch (e) {
      return time;
    }
  }

  void startTimer(String startTime) {
    final attendanceProvider = Provider.of<AttendanceProvider>(
      context,
      listen: false,
    );
    try {
      setState(() {
        isPunchedIn = true;
      });
      final now = DateTime.now();
      final startParts = startTime.split(":");
      final startDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(startParts[0]),
        int.parse(startParts[1]),
      );
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        final currentTime = DateTime.now();
        setState(() {
          if (currentTime.isBefore(startDateTime)) {
            _duration = Duration.zero;
          } else {
            _duration = currentTime.difference(startDateTime);
          }
        });
      });
    } catch (e) {
      debugPrint("Timer Error: $e");
      setState(() {
        isPunchedIn = false;
      });
    }
  }

  void getLocationData(BuildContext context) async {
    try {
      final attendanceProvider = Provider.of<AttendanceProvider>(
        context,
        listen: false,
      );
      Position? position = await getUserLocation();
      if (position == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unable to fetch location")),
        );
        return;
      }

      double latitude = position.latitude;
      double longitude = position.longitude;
      final prefs = await SharedPreferences.getInstance();
      double officeLat = prefs.getDouble('officeLatitude') ?? 0.0;
      double officeLng = prefs.getDouble('officeLongitude') ?? 0.0;
      double allowedRadius = prefs.getDouble('attendanceRadius') ?? 100;
      bool allowOutside = prefs.getBool('allowOutsideLocation') ?? false;
      double distance = Geolocator.distanceBetween(
        latitude,
        longitude,
        officeLat,
        officeLng,
      );

      debugPrint(" USER LOCATION: $latitude , $longitude");
      debugPrint(" OFFICE LOCATION: $officeLat , $officeLng");
      debugPrint(" DISTANCE: $distance meters");
      debugPrint(" DEVICE ID: $deviceId");
      if (!(allowOutside || distance <= allowedRadius)) {
        showOutOfRangeDialog(context, distance);
        return;
      }
      final currentTimestamp = await attendanceProvider.getPublicTime();
      if (currentTimestamp == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Unable to fetch time")));
        return;
      }
      final checkInResponse = await attendanceProvider.PostAttendanceData(
        latitude: latitude,
        longitude: longitude,
        device_id: DeviceManager.deviceId,
        timestamp: currentTimestamp,
      );

      if (attendanceProvider.error == null) {
        final data = attendanceProvider.postWalletResponse?.data;
        if (data != null) {
          final prefs = await SharedPreferences.getInstance();
          final shiftStart = checkInResponse?.data!.punchInTime!;
          String shiftEnd = data.shift?.end ?? "18:00";
          await prefs.setString('shiftStart', shiftStart!);
          await prefs.setString('shiftEnd', shiftEnd);
          await prefs.setString('punchTime', currentTimestamp);
          attendanceProvider.shiftStart = shiftStart;
          attendanceProvider.shiftEnd = shiftEnd;
          startTimer(shiftStart!);
        }

        showAttendanceSuccessDialog(context);
      } else if (attendanceProvider.error!.toLowerCase().contains("already")) {
        await prefs.setString('shiftStart', attendanceProvider.startTime!);
        showAlreadyMarkedDialog(context);
      } else {
        debugPrint(" API ERROR: ${attendanceProvider.error}");

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(attendanceProvider.error!)));
      }
    } catch (e) {
      debugPrint(" ERROR: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  void punchOut(BuildContext context) async {
    try {
      final attendanceProvider = Provider.of<AttendanceProvider>(
        context,
        listen: false,
      );
      Position? position = await getUserLocation();
      if (position == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unable to fetch location")),
        );
        return;
      }

      double latitude = position.latitude;
      double longitude = position.longitude;
      final prefs = await SharedPreferences.getInstance();
      double officeLat = prefs.getDouble('officeLatitude') ?? 0.0;
      double officeLng = prefs.getDouble('officeLongitude') ?? 0.0;
      double allowedRadius = prefs.getDouble('attendanceRadius') ?? 100;
      bool allowOutside = prefs.getBool('allowOutsideLocation') ?? false;
      double distance = Geolocator.distanceBetween(
        latitude,
        longitude,
        officeLat,
        officeLng,
      );

      debugPrint(" USER LOCATION: $latitude , $longitude");
      debugPrint(" OFFICE LOCATION: $officeLat , $officeLng");
      debugPrint(" DISTANCE: $distance meters");
      debugPrint(" DEVICE ID: $deviceId");
      if (!(allowOutside || distance <= allowedRadius)) {
        showOutOfRangeDialog(context, distance);
        return;
      }
      final currentTimestamp = await attendanceProvider.getPublicTime();
      if (currentTimestamp == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Unable to fetch time")));
        return;
      }

      final checkInResponse = await attendanceProvider.PostAttendanceOutData(
        latitude: latitude,
        longitude: longitude,
        timestamp: currentTimestamp,
      );
      if (attendanceProvider.error == null) {
        final data = attendanceProvider.panchOutResponse?.data;
        if (data != null) {
          final prefs = await SharedPreferences.getInstance();
          final shiftStart = checkInResponse?.data!.punchInTime!;
          String shiftEnd = data.punchOutTime ?? "18:00";
          await prefs.remove('shiftStart');
          await prefs.remove('shiftEnd');
          await prefs.remove('punchTime');
          _timer?.cancel();
          attendanceProvider.shiftStart = shiftStart;
          attendanceProvider.shiftEnd = shiftEnd;
        }

       // showPunchOutSuccessDialog(context);
        showPunchOutConfirmDialog(context);
        setState(() {
          isPunchedIn = false;
          _timer?.cancel();
          _duration = Duration.zero;
        });
      } else if (attendanceProvider.error!.toLowerCase().contains("already")) {
        await prefs.setString('shiftStart', attendanceProvider.startTime!);
        showAlreadyMarkedDialog(context);
      } else {
        debugPrint(" API ERROR: ${attendanceProvider.error}");

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(attendanceProvider.error!)));
      }
    } catch (e) {
      debugPrint(" ERROR: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }
  void showPunchOutConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          title: Center(
            child: CustomText(
              "Confirm",
              size: 18,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.help_outline,
                color: Colors.orange,
                size: 60,
              ),
              SizedBox(height: 10),
              CustomText(
                "Are you sure you want to Punch Out?",
                size: 13,
                weight: FontWeight.w400,
                color: ColorResource.black,
              ),
            ],
          ),

          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CommonAppButton(
                    text: "No",
                    backgroundColor1: Colors.grey,
                    backgroundColor2: Colors.grey,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CommonAppButton(
                    text: "Yes",
                    backgroundColor1: ColorResource.button1,
                    backgroundColor2: ColorResource.button1,
                    onPressed: () {
                      Navigator.pop(context); // close confirm

                      /// 👉 Call success dialog
                      showPunchOutSuccessDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  void showAlreadyMarkedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.orange,
                    size: 40,
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  "Already Marked",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Your attendance has already been marked for today.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showPunchOutSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          title: Center(
            child: CustomText(
              "Success",
              size: 18,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                color: Colors.orange,
                size: 60,
              ),
              SizedBox(height: 10),
              CustomText(
                "Punch Out Successfully",
                size: 13,
                weight: FontWeight.w400,
                color: ColorResource.black,
              ),
            ],
          ),

          actions: [
            CommonAppButton(
              text: "OK",
              backgroundColor1: ColorResource.button1,
              backgroundColor2: ColorResource.button1,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showAttendanceSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Center(
            child: CustomText(
              "Success",
              size: 18,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 10),
              CustomText(
                "Attendance Marked Successfully",
                size: 13,
                weight: FontWeight.w400,
                color: ColorResource.black,
              ),
            ],
          ),
          actions: [
            CommonAppButton(
              text: "OK",
              backgroundColor1: ColorResource.button1,
              backgroundColor2: ColorResource.button1,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showOutOfRangeDialog(BuildContext context, double distance) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 40),

                const SizedBox(height: 20),

                CustomText(
                  'Out of Range',
                  size: 20,
                  weight: FontWeight.w700,
                  color: ColorResource.black,
                ),

                const SizedBox(height: 10),

                CustomText(
                  "You are ${distance.toStringAsFixed(0)}m away from the office premises. Please move closer to clock in.",
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                  align: TextAlign.center,
                ),

                const SizedBox(height: 25),

                CommonAppButton(
                  text: 'Try Again',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor1: ColorResource.button1,
                  backgroundColor2: ColorResource.button1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Position?> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled');
      return null;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permission permanently denied');
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }

  Color getStatusColor(WeeklySummary item) {
    if (item.isPresent == true) return Colors.green;
    if (item.isAbsent == true) return Colors.red;
    if (item.isLeave == true) return Colors.blue;
    if (item.isOfficeOff == true) return Colors.grey;
    return Colors.transparent;
  }

  String getDay(String? day) {
    if (day == null || day.length < 2) return "";
    return day.substring(0, 2).toUpperCase(); // MO, TU
  }

  String getDayNumber(String? date) {
    if (date == null) return "";
    return DateTime.parse(date).day.toString();
  }

  @override
  Widget build(BuildContext context) {
    restoreShiftAndTimer();
    return Consumer<AttendanceProvider>(
      builder: (context, attendanceProvider, child) {
        final duration = attendanceProvider.duration;
        String twoDigits(int n) => n.toString().padLeft(2, '0');
        final hours = twoDigits(duration.inHours);
        final minutes = twoDigits(duration.inMinutes.remainder(60));
        final seconds = twoDigits(duration.inSeconds.remainder(60));
        return SafeArea(
          child: Scaffold(
            appBar: CommonAppBar(title: 'Attendance', isBack: false),
            backgroundColor: ColorResource.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 7,
                            color: ColorResource.button1,
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              timerText,
                              size: 25,
                              weight: FontWeight.w700,
                              color: ColorResource.black,
                            ),
                            CustomText(
                              'TOTAL HOURS TODAY',
                              size: 10,
                              weight: FontWeight.w400,
                              color: ColorResource.grayText,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        checkInCard(
                          image: AppImages.checkIn,
                          title: 'Clock In',
                          subTitle: formatTime(
                            attendanceProvider.shiftStart ?? "09:00",
                          ),
                          backgroundColor: ColorResource.white,
                          subtitleColor: ColorResource.grayText,
                          titleColor: ColorResource.black,
                          onTap: () {
                            getLocationData(context);
                          },
                        ),

                        checkInCard(
                          image: AppImages.checkOut,
                          title: 'Clock Out',
                          subTitle: 'End Shift',
                          backgroundColor: ColorResource.button1,
                          subtitleColor: ColorResource.white,
                          titleColor: ColorResource.white,
                          onTap: () {
                            punchOut(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: ColorResource.button1,
                          size: 15,
                        ),
                        SizedBox(width: 2),
                        CustomText(
                          'Office Premises • Tech Park Entrance',
                          size: 12,
                          weight: FontWeight.w400,
                          color: ColorResource.button1,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          "Today's Timeline",
                          size: 16,
                          weight: FontWeight.w700,
                          color: ColorResource.black,
                        ),
                        CustomText(
                          'View All',
                          size: 12,
                          weight: FontWeight.w600,
                          color: ColorResource.button1,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          children: [
                            CustomImageView(
                              imagePath: AppImages.clockInImage,
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(
                              height: 25,
                              child: VerticalDivider(
                                thickness: 1,
                                color: ColorResource.searchBar,
                              ),
                            ),
                            CustomImageView(
                              imagePath: AppImages.checkOutImage,
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'Clock In',
                              size: 14,
                              weight: FontWeight.w700,
                              color: ColorResource.black,
                            ),
                            CustomText(
                              formatTime(
                                attendanceProvider.shiftStart ?? "09:00",
                              ),
                              size: 12,
                              weight: FontWeight.w400,
                              color: ColorResource.gray,
                            ),
                            SizedBox(height: 25),
                            CustomText(
                              'Clock Out',
                              size: 14,
                              weight: FontWeight.w700,
                              color: ColorResource.black,
                            ),

                            CustomText(
                              attendanceProvider
                                  ?.todayAttendanceModel
                                  ?.data
                                  ?.sessions !=
                                  null &&
                                  attendanceProvider!
                                      .todayAttendanceModel!
                                      .data!
                                      .sessions!
                                      .isNotEmpty
                                  ? attendanceProvider
                                  .todayAttendanceModel!
                                  .data!
                                  .sessions!
                                  .last
                                  .clockOut
                                  .toString() ??
                                  ""
                                  : "—",
                              size: 12,
                              weight: FontWeight.w400,
                              color: ColorResource.gray,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    CustomText(
                      'October ${DateTime.now().year} Summary',
                      size: 16,
                      weight: FontWeight.w700,
                      color: ColorResource.black,
                    ),
                    SizedBox(height: 10),
                    weeklyCalendar(
                      attendanceProvider
                          .todayAttendanceModel
                          ?.data
                          ?.weeklySummary ??
                          [],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget weeklyCalendar(List<WeeklySummary> weeklySummary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weeklySummary.map((item) {
              final today = DateTime.now();
              final itemDate = item.date != null
                  ? DateTime.parse(item.date!)
                  : null;

              final isToday =
                  itemDate != null &&
                      itemDate.year == today.year &&
                      itemDate.month == today.month &&
                      itemDate.day == today.day;

              final color = getStatusColor(item);

              return Expanded(
                child: Column(
                  children: [
                    Text(
                      getDay(item.day),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: isToday ? Colors.blue : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        getDayNumber(item.date),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isToday ? Colors.white : Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              legendItem(Colors.green, "Present"),
              legendItem(Colors.red, "Absent"),
              legendItem(Colors.blue, "Leave"),
            ],
          ),
        ],
      ),
    );
  }

  Widget legendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget checkInCard({
    required String image,
    required String title,
    required String subTitle,
    required Color backgroundColor,
    required Color titleColor,
    required Color subtitleColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 137,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: const Color(0xFFD9EAFB)),
            borderRadius: BorderRadius.circular(24),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 2,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            CustomText(
              title,
              size: 16,
              weight: FontWeight.w700,
              color: titleColor,
            ),
            SizedBox(height: 10),
            CustomText(
              subTitle,
              size: 10,
              weight: FontWeight.w400,
              color: subtitleColor,
            ),
          ],
        ),
      ),
    );
  }
}
