import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nexwage/screen/home_screen/provider/home_provider.dart';
import 'package:nexwage/screen/home_screen/ui/dailBox/showPunchOutConfirmDialog.dart';
import 'package:nexwage/screen/home_screen/ui/reportHead.dart';
import 'package:nexwage/screen/profile/ui/profile_screen.dart';
import 'package:nexwage/screen/version_update/provider/version_provider.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:nexwage/widget/navigator_method.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../util/core/device_id/device_service.dart';
import '../../../widget/commonAppButton.dart';
import '../../attendance_screen/provider/attendance_provider.dart';
import '../../holidays/ui/holidays_Screen.dart';
import '../../hr_reports/ui/hr_reports.dart';
import '../../profile/provider/profile_provider.dart';
import '../../project/ui/project_screen.dart';
import '../../reimbursement/ui/reimbursement_screen.dart';
import '../../tasks/ui/tasks_screen.dart';
import '../../tickets/ui/tickets_screen.dart';
import 'dart:io';
import 'package:flutter/services.dart';

import 'Announecement.dart';
import '_buildCardItem.dart';
import 'hedingTitle.dart';
import 'main_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;
  Duration _duration = Duration();
  bool isPunchedIn = false;
  String deviceId = "";
  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  void loadInitialData() async {
    loadDeviceId();
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false,);
    final appProvider = Provider.of<AppVersionProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    await profileProvider.getProfileData();
    await appProvider.fetchAppVersion();
    await homeProvider.getHomeData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
      final attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false,);
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
    final attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false,);
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
      final attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false,);
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
        ShowDailBox.showOutOfRangeDialog(context, distance);
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
        ShowDailBox.showAttendanceSuccessDialog(context);
      } else if (attendanceProvider.error!.toLowerCase().contains("already")) {
        await prefs.setString('shiftStart', attendanceProvider.startTime!);
        ShowDailBox.showAlreadyMarkedDialog(context);
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
      final attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false,);
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
        ShowDailBox.showOutOfRangeDialog(context, distance);
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
          attendanceProvider.shiftStart = shiftStart;
          attendanceProvider.shiftEnd = shiftEnd;
        }
        ShowDailBox.showPunchOutConfirmDialog(context);
        setState(() {
          isPunchedIn = false;
          _timer?.cancel();
          _duration = Duration.zero;
        });
      } else if (attendanceProvider.error!.toLowerCase().contains("already")) {
        await prefs.setString('shiftStart', attendanceProvider.startTime!);
        ShowDailBox.showAlreadyMarkedDialog(context);
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

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    restoreShiftAndTimer();
    return Consumer4<ProfileProvider, AppVersionProvider, AttendanceProvider, HomeProvider>(
      builder: (context, profileprovider, appProvider, attendanceProvider, homeProvder, child,) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.854,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorResource.button1,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 60),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    navPush(context: context, action: ProfileScreen(),);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: ColorResource.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            getGreeting(),
                                            size: 12,
                                            weight: FontWeight.w400,
                                            color: ColorResource.white,
                                          ),
                                          CustomText(
                                            profileprovider.getProfileModel?.data?.fullName ?? "",
                                            size: 16,
                                            weight: FontWeight.w600,
                                            color: ColorResource.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                const Spacer(),
                                CustomImageView(
                                  imagePath: AppImages.bellImage,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 120,
                        left: 20,
                        right: 20,
                        bottom: -40,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: ShapeDecoration(
                                    color: ColorResource.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 18.40,
                                        offset: Offset(19, -5),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),

                                  child: buildCardItem(
                                    timer: timerText,
                                    shiftStatus: isPunchedIn ? "ON SHIFT" : "OFF SHIFT",
                                    buttonText: isPunchedIn ? "Clock-Out" : "Clock-In",
                                    shift: "Shift ${formatTime(attendanceProvider.shiftStart ?? "09:00")} - ""${formatTime(attendanceProvider.shiftEnd ?? "18:00")}",
                                    onTap: isPunchedIn ? () {punchOut(context);} : () {getLocationData(context);},
                                  ),
                                ),
                                SizedBox(height: 10),
                                hedingTitle(title: 'Reporting Head'),
                                SizedBox(height: 10),
                                reportHead(
                                  title: homeProvder.homeModel?.data?.reportingHead?.name ?? "N/A",
                                  subTitle: homeProvder.homeModel?.data?.reportingHead?.designation ?? "N/A",
                                  email: homeProvder.homeModel?.data?.reportingHead?.email ?? "N/A",
                                  mobileNumber: '+91 ${homeProvder.homeModel?.data?.reportingHead?.phone ?? "N/A"}',
                                ),
                                SizedBox(height: 10),
                                hedingTitle(title: 'Main Menu'),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    mainMenu(
                                      onTap: () {
                                        navPush(context: context, action: HrReportsScreen(),);
                                      },
                                      title: 'HR REPORTS', image: AppImages.hrReport, color: ColorResource.menu1,
                                    ),
                                    mainMenu(
                                      onTap: () {
                                        navPush(context: context, action: HolidaysScreen(),);
                                      },
                                      title: 'HOLIDAYS', image: AppImages.holiday, color: ColorResource.menu2,
                                    ),
                                    mainMenu(
                                      onTap: () {
                                        navPush(context: context, action: ReimbursementScreen(),);
                                      },
                                      title: 'REIMBURSEMENT', image: AppImages.remebe, color: ColorResource.menu3,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    mainMenu(
                                      onTap: () {
                                        navPush(context: context, action: ProjectScreen(),);
                                      },
                                      title: 'PROJECTS', image: AppImages.project, color: ColorResource.menu4,
                                    ),
                                    mainMenu(
                                      onTap: () {
                                        navPush(context: context, action: TicketScreen(),);
                                      },
                                      title: 'TICKETS', image: AppImages.ticket, color: ColorResource.menu5,
                                    ),
                                    mainMenu(
                                      onTap: () {
                                        navPush(context: context, action: TasksScreen(),);
                                      },
                                      title: 'TASKS', image: AppImages.task, color: ColorResource.menu6,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                hedingTitle(title: 'Announcements'),
                                SizedBox(height: 10),
                                Announecement(
                                  image: AppImages.announcement,
                                  title: 'Townhall Meeting Today',
                                  subTitle: 'Join at 4:00 PM in the Main\nCafeteria',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
    );
  }
}
