import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/navigator_method.dart';
import '../../util/constants/sizes.dart';
import '../bottom_bar/ui/bottom_bar_screen.dart';
import '../onBording_screen/ui/on_bording_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  // ✅ FIXED METHOD
  void _checkLogin() async {
    await Future.delayed(const Duration(milliseconds: 4500));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    print("SAVED TOKEN: $token");

    if (token != null && token.isNotEmpty) {
      // ✅ Go to Home Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      // ❌ Go to Onboarding
      navPush(context: context, action: OnBoardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xffD2DFFD),
        child: Center(
          // child: CustomImageView(
          //   imagePath: AppImages.logo,
          //   height: AppSizes.h(59),
          //   width: AppSizes.w(280),
          //   fit: BoxFit.cover,
          // ),
          child: Image.asset("assets/images/NexwageSplash.gif"),
        ),
      ),
    );
  }
}
