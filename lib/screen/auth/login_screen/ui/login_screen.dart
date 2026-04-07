import 'package:flutter/material.dart';
import 'package:nexwage/screen/auth/login_screen/provider/login_provider.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:nexwage/widget/navigator_method.dart';
import 'package:provider/provider.dart';

import '../../../bottom_bar/ui/bottom_bar_screen.dart';
import '../../forget_password/ui/forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          top: false,
          child: Scaffold(
            body: Container(
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
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 100),
                      Center(
                        child: CustomText(
                          'Welcome Back',
                          size: 26,
                          weight: FontWeight.w700,
                          color: ColorResource.black,
                        ),
                      ),
                      Center(
                        child: CustomText(
                          'Login to continue',
                          size: 14,
                          weight: FontWeight.w400,
                          color: ColorResource.black,
                        ),
                      ),
                      SizedBox(height: 30),
                      CustomText(
                        'Email/ Employee ID',
                        size: 14,
                        weight: FontWeight.w400,
                        color: ColorResource.black,
                      ),
                      CommonTextFormField(
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        controller: provider.emailController,
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        'Password',
                        size: 14,
                        weight: FontWeight.w400,
                        color: ColorResource.black,
                      ),
                      CommonTextFormField(
                        hintText: 'Enter your password',
                        controller: provider.passController,
                        obscureText: true,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: isChecked
                                    ? ColorResource.button1
                                    : Colors.transparent,
                                border: Border.all(
                                  width: 1,
                                  color: ColorResource.button1,
                                ),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: isChecked
                                  ? Icon(
                                      Icons.check,
                                      size: 12,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),

                          SizedBox(width: 5),

                          CustomText(
                            'Remember Me',
                            size: 12,
                            weight: FontWeight.w400,
                            color: ColorResource.black,
                          ),

                          Spacer(),

                          GestureDetector(
                            onTap: () {
                              navPush(context: context, action: ForgetPasswordScreen(),);
                            },
                            child: CustomText(
                              'Forget Password?',
                              size: 12,
                              weight: FontWeight.w600,
                              color: ColorResource.button1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      CommonAppButton(
                        text: 'Login',
                        isLoading: provider.loading,
                        onPressed: () {
                          provider.sendOtpProvider(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
