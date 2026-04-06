  import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/navigator_method.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../util/constants/sizes.dart';
import '../bottom_bar/ui/bottom_bar_screen.dart';
import '../onBording_screen/ui/on_bording_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../version_update/provider/version_provider.dart';

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
    loadInitialData();
  }

  void loadInitialData() async {
    final appProvider = Provider.of<AppVersionProvider>(context, listen: false);
    await appProvider.fetchAppVersion();
    if (mounted) {
      await checkVersionAndShowDialog(appProvider);
    }
  }
  bool _dialogShown = false;
  void showUpdateDialog(String message, bool forceUpdate) {
    if (_dialogShown) return;
    _dialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
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
                  Text(
                    forceUpdate ? "Update Required" : "Update Available",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 25),

                  Column(
                    children: [
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

                      if (!forceUpdate) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
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
        currentVersion = "1.0.0";
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
