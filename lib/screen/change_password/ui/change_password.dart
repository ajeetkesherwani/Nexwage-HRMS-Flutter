import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  List<String> title = [
    'At least 8 characters long',
    'Contains a capital letter',
    'Includes at least one number',
    'Includes a special character (@, #, \$)',
];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'Change Password'),
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                      imagePath: AppImages.changepassword,
                    height: 48,
                    width: 48,
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Secure Your Account',
                    size: 20,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Create a strong, unique password to ensure your HR data stays protected.',
                    size: 14,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Current Password',
                    size: 14,
                    weight: FontWeight.w600,
                  ),
                  CommonTextFormField(
                    obscureText: true,
                    hintText: 'Enter Current Password',
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'New Password',
                    size: 14,
                    weight: FontWeight.w600,
                  ),
                  CommonTextFormField(
                    obscureText: true,
                    hintText: 'Enter New Password',
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Confirm New Password',
                    size: 14,
                    weight: FontWeight.w600,
                  ),
                  CommonTextFormField(
                    obscureText: true,
                    hintText: 'Enter Confirm New Password',
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorResource.searchBar
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'PASSWORD STRENGTH REQUIREMENTS',
                          size: 12,
                          weight: FontWeight.w700,
                          color: ColorResource.black,
                        ),
                        SizedBox(height: 5,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: title.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5), // spacing between lines
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                    imagePath: AppImages.passwordUpdate,
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: CustomText(
                                      item,
                                      size: 14,
                                      weight: FontWeight.w400,
                                      color: ColorResource.gray,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 25,),
                  CommonAppButton(
                      text: 'Update Password',
                      backgroundColor1: ColorResource.button1,
                      backgroundColor2: ColorResource.button1,
                      onPressed: (){}
                  ),
                  SizedBox(height: 10,),
                  CommonAppButton(
                      text: 'Cancel',
                      backgroundColor1: ColorResource.white,
                      backgroundColor2: ColorResource.white,
                      textColor: ColorResource.gray,
                      onPressed: (){}
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
