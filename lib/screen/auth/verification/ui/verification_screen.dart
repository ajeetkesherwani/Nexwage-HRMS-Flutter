import 'package:flutter/material.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/navigator_method.dart';
import 'package:pinput/pinput.dart';
import '../../../../util/color/app_colors.dart';
import '../../../../widget/custom_text.dart';
import '../../reset_password/ui/reset_password.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({super.key,required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController otpController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0,3),
          )
        ],
      ),
    );

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
                  'Verification Code',
                  size: 26,
                  weight: FontWeight.w700,
                  color: ColorResource.black,
                ),
                SizedBox(height: 5,),
                CustomText(
                  'We have sent a 4-digit code to',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.black,
                ),
                CustomText(
                  widget.email,
                  size: 14,
                  weight: FontWeight.w600,
                  color: ColorResource.black,
                ),
                SizedBox(height: 30,),
                Pinput(
                  controller: otpController,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  onChanged: (value) {
                    setState(() {}); // 👈 IMPORTANT
                  },
                ),
                SizedBox(height: 20,),
                CommonAppButton(
                    text: 'Verify  OTP',
                    onPressed: (){
                      navPush(context: context, action: ResetPassword());
                    }
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      'Didn’t receive code? ',
                      size: 14,
                      weight: FontWeight.w400,
                      color: ColorResource.black.withOpacity(0.5),
                    ),
                    CustomText(
                      'Resend Code',
                      size: 14,
                      weight: FontWeight.w400,
                      color: ColorResource.button1,
                    )
                  ],
                )

              ],
            ),
          ),
        )
    );
  }
}
