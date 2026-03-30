import 'package:flutter/material.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:nexwage/widget/navigator_method.dart';

import '../../../../util/color/app_colors.dart';
import '../../verification/ui/verification_screen.dart';
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController=TextEditingController();
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
                  'Forgot Password?',
                  size: 26,
                  weight: FontWeight.w700,
                  color: ColorResource.black,
                ),
                SizedBox(height: 10,),
                CustomText(
                  'Enter your registered email to receive an OTP to reset your password.',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.black,
                ),
                SizedBox(height: 30,),
                CustomText(
                  'Work Email',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.black,
                ),
                CommonTextFormField(
                  hintText: 'brijesh@gmail.com',
                  controller: emailController,
                  prefixIcon: Icons.mail_outline,
                ),
                SizedBox(height: 20,),
                CommonAppButton(text: 'Send OTP', onPressed: (){
                  navPush(context: context, action: VerificationScreen(email: emailController.text,));
                })
              ],
            ),
          ),
        )
    );
  }
}
