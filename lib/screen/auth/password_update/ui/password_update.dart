import 'package:flutter/material.dart';
import 'package:nexwage/screen/auth/login_screen/ui/login_screen.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/customImageView.dart';

import '../../../../util/color/app_colors.dart';
import '../../../../widget/commonAppButton.dart';
import '../../../../widget/custom_text.dart';
import '../../../../widget/navigator_method.dart';
class PasswordUpdate extends StatefulWidget {
  const PasswordUpdate({super.key});

  @override
  State<PasswordUpdate> createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            height: double.infinity,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.50, 1.00),
                end: Alignment(0.50, 0.00),
                colors: [ColorResource.onBording1, ColorResource.onBording2],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                GestureDetector(
                    onTap: (){
                      navPop(context: context);
                    },
                    child: Icon(Icons.arrow_back_ios,size: 20,color: ColorResource.black,)),
                SizedBox(height: 50,),
                Center(
                  child: CustomImageView(
                      imagePath: AppImages.passwordUpdate,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30,),
                Center(
                  child: CustomText(
                    'Password Updated',
                    size: 26,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                ),
                SizedBox(height: 20,),
                CustomText(
                  'Your password has been reset successfully. you can now login with your new password.',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.black,
                ),



                SizedBox(height: 25,),
                CommonAppButton(
                    text: 'Back to login',
                    onPressed: (){
                      navPush(context: context, action: LoginScreen());
                    }
                )
              ],
            ),
          ),
        )
    );
  }
}
