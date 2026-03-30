import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';

class AddQualification extends StatefulWidget {
  const AddQualification({super.key});

  @override
  State<AddQualification> createState() => _AddQualificationState();
}

class _AddQualificationState extends State<AddQualification> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'Add Qualification'),
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'DEGREE NAME',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    hintText: 'e.g. Bachelor of Science',
                    prefixIcon: Icons.school_outlined,
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'INSTITUTION',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    hintText: 'e.g. Stanford University',
                    prefixIcon: Icons.account_balance,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'YEAR OF PASSING',
                              size: 14,
                              weight: FontWeight.w600,
                              color: ColorResource.black,
                            ),
                            SizedBox(height: 5),
                            CommonTextFormField(
                              hintText: 'Select Year',
                              suffixIcon: Icon(Icons.keyboard_arrow_down_sharp,color: ColorResource.grayText,),
                              prefixIcon: Icons.calendar_today,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'SCORE',
                              size: 14,
                              weight: FontWeight.w600,
                              color: ColorResource.black,
                            ),
                            SizedBox(height: 5),
                            CommonTextFormField(
                              prefixIcon: Icons.star_border,
                              hintText: 'e.g. 3.8 or 85%',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'CERTIFICATE ATTACHMENT',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                    decoration: BoxDecoration(
                      color: ColorResource.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFFCBD5E1),
                      )
                    ),child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: ColorResource.searchBar,
                        ),child: Icon(Icons.cloud_upload_outlined,color: ColorResource.button1,),
                      ),
                      SizedBox(height: 10,),
                      CustomText(
                        'Upload Certificate',
                        size: 14,
                        weight: FontWeight.w400,
                        color: ColorResource.gray,
                      ),
                      SizedBox(height: 10,),
                      CustomText(
                        'PDF, JPG or PNG (max. 5MB)',
                        size: 12,
                        weight: FontWeight.w400,
                        color: ColorResource.grayText,
                      )
                    ],
                  ),
                  ),
                  SizedBox(height: 50,),
                  CommonAppButton(
                      backgroundColor1: ColorResource.button1,
                      backgroundColor2: ColorResource.button1,
                      text: 'Save Qualification',
                      onPressed: (){}
                  ),
                  SizedBox(height: 10,),
                  CommonAppButton(
                      backgroundColor1: ColorResource.white,
                      backgroundColor2: ColorResource.white,
                      textColor: ColorResource.gray,
                      borderColor: ColorResource.grayText,
                      text: 'Cancel',
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
