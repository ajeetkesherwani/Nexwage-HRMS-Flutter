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

import '../../../util/core/attendence_service/attendence_service.dart';
import '../../../util/core/attendence_service/commontimer_helper.dart';
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
    Provider.of<AttendanceProvider>(
      context,
      listen: false,
    ).getTodayAttendanceDate();
  }

  String deviceId = "";
  void loadDeviceId() async {
    String id = await DeviceService.getDeviceId();
    setState(() {
      deviceId = id;
    });
  }

  //Panch - Out

  void getLocationPanchOutData(BuildContext context) async {
    Position? position = await getUserLocation();

    if (position != null) {
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

      print("Latitude: $latitude");
      print("Longitude: $longitude");
      print("Distance: $distance meters");
      print("Device ID: $deviceId");
      print("Time Stamp: $timestamp");
      print("officeLat: $officeLat");
      print("officeLng: $officeLng");
      print("allowedRadius: $allowedRadius");
      print("allowOutside: $allowOutside");

      if (allowOutside || distance <= allowedRadius) {
        print("✅ Attendance Marked");

        Map<String, dynamic> data = {
          "latitude": latitude,
          "longitude": longitude,
          // "device_id": deviceId,
          "timestamp": getCurrentTimestamp(),
        };
        final attendanceProvider = Provider.of<AttendanceProvider>(
          context,
          listen: false,
        );

        await attendanceProvider.PostAttendanceOutData(
          latitude: latitude,
          longitude: longitude,
          //device_id: deviceId,
          timestamp: getCurrentTimestamp(),
        );
        if (attendanceProvider.error == null) {
          showPunchOutSuccessDialog(context);
        } else {
          print("API ERROR: ${attendanceProvider.error}");
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(attendanceProvider.error!)));
        }
        print("API DATA: $data");
        showPunchOutSuccessDialog(context);
      } else {
        double extraDistance = distance;

        showPunchOutOutOfRangeDialog(context, extraDistance);
      }
    }
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

          /// 🔹 Title
          title: Center(
            child: CustomText(
              "Success",
              size: 18,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
          ),

          /// 🔹 Content
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout, // 👈 Punch Out icon
                color: Colors.orange,
                size: 60,
              ),
              SizedBox(height: 10),
              CustomText(
                "Punch Out Successfully", // 👈 changed text
                size: 13,
                weight: FontWeight.w400,
                color: ColorResource.black,
              ),
            ],
          ),

          /// 🔹 Button
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

  void showPunchOutOutOfRangeDialog(BuildContext context, double distance) {
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
                Icon(
                  Icons.logout, // 👈 better for punch out
                  color: Colors.orange,
                  size: 40,
                ),

                const SizedBox(height: 20),

                CustomText(
                  'Out of Range',
                  size: 20,
                  weight: FontWeight.w700,
                  color: ColorResource.black,
                ),

                const SizedBox(height: 10),

                CustomText(
                  "You are ${distance.toStringAsFixed(0)}m away from the office premises. Please move closer to punch out.",
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
  //Panch - In

  bool _dialogShown = false;

  Timer? _timer;
  Duration _duration = Duration();

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
    DateTime now = DateTime.now();

    if (punchTime.year == now.year &&
        punchTime.month == now.month &&
        punchTime.day == now.day) {
      final attendanceProvider = Provider.of<AttendanceProvider>(
        context,
        listen: false,
      );

      attendanceProvider.shiftStart = shiftStart;
      attendanceProvider.shiftEnd = shiftEnd;

      // 🔥 DIRECT duration calculate (important)
      final endParts = shiftEnd.split(":");

      final endDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(endParts[0]),
        int.parse(endParts[1]),
      );

      setState(() {
        if (now.isAfter(endDateTime)) {
          _duration = Duration.zero;
        } else {
          _duration = endDateTime.difference(now);
        }
      });

      // 🔥 restart timer
      startTimer(shiftStart, shiftEnd);
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

  void startTimer(String startTime, String endTime) {
    try {
      final now = DateTime.now();

      final endParts = endTime.split(":");

      final endDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(endParts[0]),
        int.parse(endParts[1]),
      );

      _timer?.cancel();

      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;

        final currentTime = DateTime.now();

        setState(() {
          if (currentTime.isAfter(endDateTime)) {
            _duration = Duration.zero;
          } else {
            _duration = endDateTime.difference(currentTime);
          }
        });
      });
    } catch (e) {
      debugPrint("Timer Error: $e");
    }
  }

  void getLocationData(BuildContext context) async {
    try {
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

      print("Latitude: $latitude");
      print("Longitude: $longitude");
      print("Distance: $distance meters");
      print("Device ID: $deviceId");
      print("Time Stamp: $timestamp");
      print("officeLat: $officeLat");
      print("officeLng: $officeLng");
      print("allowedRadius: $allowedRadius");
      print("allowOutside: $allowOutside");

      debugPrint(" USER LOCATION: $latitude , $longitude");
      debugPrint(" OFFICE LOCATION: $officeLat , $officeLng");
      debugPrint(" DISTANCE: $distance meters");
      debugPrint(" DEVICE ID: $deviceId");

      if (!(allowOutside || distance <= allowedRadius)) {
        showOutOfRangeDialog(context, distance);
        return;
      }

      final attendanceProvider = Provider.of<AttendanceProvider>(
        context,
        listen: false,
      );

      await attendanceProvider.PostAttendanceData(
        latitude: latitude,
        longitude: longitude,
        device_id: DeviceManager.deviceId,
        timestamp: getCurrentTimestamp(),
      );

      if (attendanceProvider.error == null) {
        final data = attendanceProvider.postWalletResponse?.data;

        if (data != null) {
          final prefs = await SharedPreferences.getInstance();

          String shiftStart = data.shift?.start ?? "09:00";
          String shiftEnd = data.shift?.end ?? "18:00";

          // 🔥 Save locally
          await prefs.setString('shiftStart', shiftStart);
          await prefs.setString('shiftEnd', shiftEnd);
          await prefs.setString('punchTime', DateTime.now().toIso8601String());

          // 🔥 Update provider
          attendanceProvider.shiftStart = shiftStart;
          attendanceProvider.shiftEnd = shiftEnd;

          // 🔥 Start timer
          startTimer(shiftStart, shiftEnd);
        }

        showAttendanceSuccessDialog(context);
      } else if (attendanceProvider.error!.toLowerCase().contains("already")) {
        showAlreadyMarkedDialog(context);
      } else {
        debugPrint("❌ API ERROR: ${attendanceProvider.error}");

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(attendanceProvider.error!)));
      }
    } catch (e) {
      debugPrint("🔥 ERROR: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
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
                // 🔶 Icon Circle
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

                // 🔥 Title
                Text(
                  "Already Marked",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),

                // 📝 Message
                Text(
                  "Your attendance has already been marked for today.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 25),

                // ✅ Button
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

  String getCurrentTimestamp() {
    return DateTime.now().toIso8601String(); // ✅ IST
  }

  String timestamp = DateTime.now().toIso8601String();
  Future<Position?> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled');
      return null;
    }

    // Check permission
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

    // Get current location
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
                              "$hours:$minutes:$seconds",
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
                          subTitle: '09:00 AM',
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
                            getLocationPanchOutData(context);
                          },
                        ),
                      ],
                    ),
                    // CustomText("Device ID: $deviceId"),
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
                                            .clockIn ??
                                        ""
                                  : "—",
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
                            // CustomText(
                            //   attendanceProvider?.todayAttendanceModel?.data?.sessions?.last.clockOut ?? "",
                            //   size: 12,
                            //   weight: FontWeight.w400,
                            //   color: ColorResource.gray,
                            // ),
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
          /// WEEK ROW
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
                    /// Day
                    Text(
                      getDay(item.day),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Date Circle
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

                    /// Status Dot
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

          /// Legend
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
