import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:nexwage/widget/navigator_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cmsScreen/ui/privacyPolicy.dart';
import '../../cmsScreen/ui/termsAndCondition.dart';
import '../../splash/splash_screen.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🔴 Top Icon
                CircleAvatar(
                  radius: 35,
                  backgroundColor: ColorResource.red,
                  child: Icon(Icons.logout, color: ColorResource.white, size: 30),
                ),

                SizedBox(height: 20),

               CustomText(
                 'Are you sure you want to logout?',
                 size: 18,
                 weight: FontWeight.w700,
                 color: ColorResource.black,
                 align: TextAlign.center,
               ),


                SizedBox(height: 25),

                // Buttons
                Row(
                  children: [
                 Expanded(child:
                 CommonAppButton(
                     text: 'No',
                     backgroundColor1: ColorResource.white,
                     backgroundColor2: ColorResource.white,
                     borderColor: ColorResource.red,
                     textColor: ColorResource.red,
                     onPressed: (){
                       Navigator.pop(context);
                     }
                 )),


                    SizedBox(width: 10),
                    Expanded(child:
                    CommonAppButton(
                        text: 'Yes',
                        backgroundColor1: ColorResource.red,
                        backgroundColor2: ColorResource.red,
                        onPressed: ()async{
                          await logoutUser(context);
                        }
                    )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> logoutUser(BuildContext context) async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => SplashScreen()),
          (route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'Setting'),
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  settingCard(
                    image: AppImages.privacy,
                    title: 'Privacy Policy',
                    onTap: (){
                      navPush(context: context, action: PrivaCyPolicy());
                    },
                  ),SizedBox(height: 10,),
                  settingCard(
                    image: AppImages.terms,
                    title: 'Terms & Conditions',
                    onTap: (){
                      navPush(context: context, action: TermsConditions());
                    },
                  ),SizedBox(height: 10,),
                  settingCard(
                    image: AppImages.hrimage,
                    title: 'HR Handbook',
                    onTap: (){},
                  ),SizedBox(height: 10,),
                  settingCard(
                    image: AppImages.Overlay,
                    title: 'Company Policies',
                    onTap: (){},
                  ),
                  SizedBox(height: 100,),
                  GestureDetector(
                    onTap: () {
                      showLogoutDialog(context);
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, size: 25, color: ColorResource.red),
                          SizedBox(width: 10),
                          CustomText(
                            'Logout',
                            size: 16,
                            weight: FontWeight.w600,
                            color: ColorResource.red,
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
  Widget settingCard({
    required String image,
    required String title,
    required VoidCallback onTap,
}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorResource.searchBar,
        ),child: Row(
        children: [
          CustomImageView(
              imagePath: image,
            height: 40,
            width: 40,
          ),
          SizedBox(width: 10,),
          CustomText(
            title,
            size: 16,
            weight: FontWeight.w400,
            color: ColorResource.black,
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios,color: ColorResource.gray,size: 20,)
        ],
      ),
      ),
    );
  }
}
