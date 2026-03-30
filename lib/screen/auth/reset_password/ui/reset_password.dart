import 'package:flutter/material.dart';
import 'package:nexwage/widget/commonTextFormField.dart';

import '../../../../util/color/app_colors.dart';
import '../../../../widget/commonAppButton.dart';
import '../../../../widget/custom_text.dart';
import '../../../../widget/navigator_method.dart';
import '../../password_update/ui/password_update.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                SizedBox(height: 30,),
                CustomText(
                  'Reset Password',
                  size: 26,
                  weight: FontWeight.w700,
                  color: ColorResource.black,
                ),
                SizedBox(height: 10,),
                CustomText(
                  'Set a new password for your account.',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.black,
                ),


                SizedBox(height: 30,),
                CustomText(
                    'New Password',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.black,
                ),
                CommonTextFormField(
                  hintText: 'New Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                SizedBox(height: 20,),
                CustomText(
                  'Confirm Password',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.black,
                ),
                CommonTextFormField(
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                SizedBox(height: 15,),
                CommonAppButton(
                    text: 'Update Password',
                    onPressed: (){
                      navPush(context: context, action: PasswordUpdate());
                    }
                )
              ],
            ),
          ),
        )
    );
  }
}
