import 'package:flutter/material.dart';
import 'package:nexwage/screen/attendance_screen/provider/attendance_provider.dart';
import 'package:nexwage/screen/auth/login_screen/provider/login_provider.dart';
import 'package:nexwage/screen/cmsScreen/provider/cmsProvider.dart';
import 'package:nexwage/screen/holidays/provider/holiday_provider.dart';
import 'package:nexwage/screen/home_screen/provider/home_provider.dart';
import 'package:nexwage/screen/hr_reports/monthly_attendance/provider/report_provider.dart';
import 'package:nexwage/screen/leave_screen/provider/leave_provider.dart';
import 'package:nexwage/screen/profile/provider/profile_provider.dart';
import 'package:nexwage/screen/reimbursement/provider/reimbursement_provider.dart';
import 'package:nexwage/screen/splash/splash_screen.dart';
import 'package:nexwage/screen/version_update/provider/version_provider.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/core/device_id/device_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DeviceManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => CmsProvider()),
        ChangeNotifierProvider(create: (_) => AppVersionProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
        ChangeNotifierProvider(create: (_) => HoliDayProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => LeaveProvider()),
        ChangeNotifierProvider(create: (_) => ReimbursementProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nex Wage',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorResource.button1),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
