import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nexwage/screen/home_screen/provider/home_provider.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _dialogShown = false;

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

    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    final appProvider = Provider.of<AppVersionProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    await profileProvider.getProfileData();
    await appProvider.fetchAppVersion();
    await homeProvider.getHomeData();

    if (mounted) {
      await checkVersionAndShowDialog(appProvider);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void loadDeviceId() async {
    String id = await DeviceService.getDeviceId();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceId', id); // ✅ SAVE

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

          // 🔥 Save locally
          await prefs.setString('shiftStart', shiftStart!);
          await prefs.setString('shiftEnd', shiftEnd);
          await prefs.setString('punchTime', currentTimestamp);

          attendanceProvider.shiftStart = shiftStart;
          attendanceProvider.shiftEnd = shiftEnd;

          // 🔥 Start timer
          startTimer(shiftStart!);
        }

        showAttendanceSuccessDialog(context);
      } else if (attendanceProvider.error!.toLowerCase().contains("already")) {
        await prefs.setString('shiftStart', attendanceProvider.startTime!);
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

          // 🔥 Save locally
          await prefs.remove('shiftStart');
          await prefs.remove('shiftEnd');
          await prefs.remove('punchTime');

          attendanceProvider.shiftStart = shiftStart;
          attendanceProvider.shiftEnd = shiftEnd;
        }

        showPunchOutSuccessDialog(context);
        setState(() {
          isPunchedIn = false;
          _timer?.cancel();
          _duration = Duration.zero;
        });
      } else if (attendanceProvider.error!.toLowerCase().contains("already")) {
        await prefs.setString('shiftStart', attendanceProvider.startTime!);
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

  void showUpdateDialog(String message, bool forceUpdate) {
    if (_dialogShown) return;
    _dialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false, // ❌ disable back button
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔥 ICON
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.system_update,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🧠 TITLE
                  Text(
                    forceUpdate ? "Update Required" : "Update Available",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 💬 MESSAGE
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 25),

                  // 🔘 BUTTONS
                  Column(
                    children: [
                      // 🚀 UPDATE BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final url = Uri.parse(
                              "https://play.google.com/store/apps/details?id=com.hrms.nexwage",
                            );

                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            "Update Now",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      // ❗ LATER BUTTON (ONLY IF NOT FORCE)
                      if (!forceUpdate) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              // ❌ CLOSE APP
                              if (Platform.isAndroid) {
                                SystemNavigator.pop();
                              } else {
                                exit(0);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Later"),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> checkVersionAndShowDialog(AppVersionProvider appProvider) async {
    try {
      if (appProvider.appVersionModel == null) return;

      String currentVersion;

      try {
        currentVersion = await appProvider.getCurrentVersion();
      } catch (e) {
        print("Fallback version used");
        currentVersion = "1.0.0"; // fallback
      }

      String apiVersion = appProvider.appVersionModel?.data?.version ?? "1.0.0";

      bool forceUpdate =
          appProvider.appVersionModel?.data?.forceUpdate ?? false;

      String message = appProvider.appVersionModel?.data?.message ?? "";

      print("Current Version: $currentVersion");
      print("API Version: $apiVersion");

      bool needUpdate = isUpdateRequired(currentVersion, apiVersion);

      if (needUpdate) {
        showUpdateDialog(message, forceUpdate);
      }
    } catch (e) {
      print("Version error: $e");
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

  // ✅ SAFE VERSION COMPARE
  bool isUpdateRequired(String currentVersion, String apiVersion) {
    List<int> current = currentVersion.split('.').map(int.parse).toList();
    List<int> api = apiVersion.split('.').map(int.parse).toList();

    int maxLength = current.length > api.length ? current.length : api.length;

    for (int i = 0; i < maxLength; i++) {
      int c = i < current.length ? current[i] : 0;
      int a = i < api.length ? api[i] : 0;

      if (a > c) return true;
      if (a < c) return false;
    }
    return false;
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
    return Consumer4<
      ProfileProvider,
      AppVersionProvider,
      AttendanceProvider,
      HomeProvider
    >(
      builder:
          (
            context,
            profileprovider,
            appProvider,
            attendanceProvider,
            homeProvder,
            child,
          ) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔵 HEADER WITH OVERLAP CARD
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

                            /// 👤 PROFILE ROW
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    navPush(
                                      context: context,
                                      action: ProfileScreen(),
                                    );
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            //'Good Morning',
                                            getGreeting(),
                                            size: 12,
                                            weight: FontWeight.w400,
                                            color: ColorResource.white,
                                          ),
                                          CustomText(
                                            profileprovider
                                                    .getProfileModel
                                                    ?.data
                                                    ?.fullName ??
                                                "",
                                            //'Daman Singh',
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

                                  child: _buildCardItem(
                                    timer: timerText,
                                    shiftStatus: isPunchedIn
                                        ? "ON SHIFT"
                                        : "OFF SHIFT",
                                    buttonText: isPunchedIn
                                        ? "Clock-Out"
                                        : "Clock-In",
                                    shift:
                                        "Shift ${formatTime(attendanceProvider.shiftStart ?? "09:00")} - "
                                        "${formatTime(attendanceProvider.shiftEnd ?? "18:00")}",
                                    onTap: isPunchedIn
                                        ? () {
                                            punchOut(context);
                                          }
                                        : () {
                                            getLocationData(context);
                                          },
                                  ),
                                ),

                                hedingTitle(title: 'Reporting Head'),
                                SizedBox(height: 10),
                                reportHead(
                                  title:
                                      homeProvder
                                          .homeModel
                                          ?.data
                                          ?.reportingHead
                                          ?.name ??
                                      "N/A",
                                  subTitle:
                                      homeProvder
                                          .homeModel
                                          ?.data
                                          ?.reportingHead
                                          ?.designation ??
                                      "N/A",
                                  email:
                                      homeProvder
                                          .homeModel
                                          ?.data
                                          ?.reportingHead
                                          ?.email ??
                                      "N/A",
                                  mobileNumber:
                                      '+91 ${homeProvder.homeModel?.data?.reportingHead?.phone ?? "N/A"}',
                                ),
                                SizedBox(height: 10),
                                hedingTitle(title: 'Main Menu'),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    mainMenu(
                                      onTap: () {
                                        navPush(
                                          context: context,
                                          action: HrReportsScreen(),
                                        );
                                      },
                                      title: 'HR REPORTS',
                                      image: AppImages.hrReport,
                                      color: ColorResource.menu1,
                                    ),
                                    mainMenu(
                                      onTap: () {
                                        navPush(
                                          context: context,
                                          action: HolidaysScreen(),
                                        );
                                      },
                                      title: 'HOLIDAYS',
                                      image: AppImages.holiday,
                                      color: ColorResource.menu2,
                                    ),
                                    mainMenu(
                                      onTap: () {
                                        navPush(
                                          context: context,
                                          action: ReimbursementScreen(),
                                        );
                                      },
                                      title: 'REIMBURSEMENT',
                                      image: AppImages.remebe,
                                      color: ColorResource.menu3,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    mainMenu(
                                      onTap: () {
                                        navPush(
                                          context: context,
                                          action: ProjectScreen(),
                                        );
                                      },
                                      title: 'PROJECTS',
                                      image: AppImages.project,
                                      color: ColorResource.menu4,
                                    ),
                                    mainMenu(
                                      onTap: () {
                                        navPush(
                                          context: context,
                                          action: TicketScreen(),
                                        );
                                      },
                                      title: 'TICKETS',
                                      image: AppImages.ticket,
                                      color: ColorResource.menu5,
                                    ),
                                    mainMenu(
                                      onTap: () {
                                        navPush(
                                          context: context,
                                          action: TasksScreen(),
                                        );
                                      },
                                      title: 'TASKS',
                                      image: AppImages.task,
                                      color: ColorResource.menu6,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                hedingTitle(title: 'Announcements'),
                                SizedBox(height: 10),
                                announcement(
                                  image: AppImages.announcement,
                                  title: 'Townhall Meeting Today',
                                  subTitle:
                                      'Join at 4:00 PM in the Main\nCafeteria',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// ⚪ OVERLAP CARD
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
    );
  }

  Widget announcement({
    required String image,
    required String title,
    required String subTitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorResource.white,
        borderRadius: BorderRadius.circular(24),
        border: const Border(
          left: BorderSide(width: 10, color: ColorResource.button1),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: image,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Column(
            children: [
              CustomText(
                title,
                size: 16,
                weight: FontWeight.w700,
                color: ColorResource.black,
              ),
              CustomText(
                subTitle,
                size: 14,
                weight: FontWeight.w400,
                color: ColorResource.grayText,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget mainMenu({
    required VoidCallback onTap,
    required String title,
    required String image,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 104,
        width: 94,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: image,
              height: 32,
              width: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            CustomText(
              title,
              size: 10,
              weight: FontWeight.w600,
              color: ColorResource.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget reportHead({
    required String title,
    required String subTitle,
    required String email,
    required String mobileNumber,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: ColorResource.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFF8FAFC)),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 12,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorResource.primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.person, color: ColorResource.button1),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title,
                    size: 14,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  CustomText(
                    subTitle,
                    size: 11,
                    weight: FontWeight.w400,
                    color: ColorResource.grayText,
                  ),
                  CustomText(
                    email,
                    size: 11,
                    weight: FontWeight.w400,
                    color: ColorResource.grayText,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFFF8FAFC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              children: [
                CustomText(
                  mobileNumber,
                  size: 12,
                  weight: FontWeight.w600,
                  color: ColorResource.grayText,
                ),
                Spacer(),
                CustomImageView(
                  imagePath: AppIcons.callIcon,
                  height: 14,
                  width: 14,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 5),
                CustomText(
                  'CALL NOW',
                  size: 11,
                  weight: FontWeight.w700,
                  color: ColorResource.button1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget hedingTitle({required String title}) {
    return CustomText(
      title,
      size: 16,
      weight: FontWeight.w600,
      color: ColorResource.black,
    );
  }

  Widget _buildCardItem({
    required String timer,
    required String shift,
    required String shiftStatus,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Attendance',
              size: 16,
              weight: FontWeight.w600,
              color: ColorResource.black,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: shiftStatus.contains("ON")
                    ? ColorResource.greenBackground
                    : ColorResource.greyBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(53),
                ),
              ),
              child: CustomText(
                shiftStatus,
                size: 10,
                weight: FontWeight.w700,
                color: shift.contains("ON")
                    ? ColorResource.green
                    : Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  timer,
                  size: 30,
                  weight: FontWeight.w700,
                  color: ColorResource.black,
                ),
                CustomText(
                  shift,
                  size: 10,
                  weight: FontWeight.w600,
                  color: ColorResource.grayText,
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: ColorResource.button1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomText(
                  buttonText,
                  size: 14,
                  weight: FontWeight.w700,
                  color: ColorResource.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
