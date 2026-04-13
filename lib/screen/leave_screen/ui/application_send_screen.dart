import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';

class ApplicationSendScreen extends StatefulWidget {
  const ApplicationSendScreen({super.key});

  @override
  State<ApplicationSendScreen> createState() => _ApplicationSendScreenState();
}

class _ApplicationSendScreenState extends State<ApplicationSendScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: ""),
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  Center(
                    child: CustomImageView(
                      imagePath: AppImages.passwordUpdate,
                      height: 96,
                      width: 96,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20,),
                  CustomText(
                    'Application Sent!',
                    size: 20,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Your leave request has been successfully\nsubmitted and is now pending approval\nfrom your manager.',
                    size: 14,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                    align: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: ShapeDecoration(
                      color: ColorResource.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFFF1F5F9),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ), child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'REQUEST DETAILS',
                        size: 14,
                        weight: FontWeight.w700,
                        color: ColorResource.black,
                      ),
                      SizedBox(height: 10,),
                      cardData(title: 'Leave Type', subtitle: 'Annual Leave'),
                      SizedBox(height: 10,),
                      cardData(title: 'Dates', subtitle: '24 Oct - 26 Oct , 2023'),
                      SizedBox(height: 10,),
                      cardData(title: 'Total Duration', subtitle: '3 Days'),
                      SizedBox(height: 10,),
                      cardData(title: 'Approving Manager', subtitle: 'Sarah Jenkins'),
                    ],
                  ),
                  ),
                  SizedBox(height: 20,),
                  CommonAppButton(
                    text: "Back to Leave Portal",
                    backgroundColor1: ColorResource.button1,
                    backgroundColor2: ColorResource.button1,
                    onPressed: (){},
                  ),
                  SizedBox(height:20,),
                  CommonAppButton(
                    backgroundColor1: ColorResource.white,
                    backgroundColor2: ColorResource.white,
                    text: "View My History",
                    textColor: ColorResource.gray,
                    borderColor: const Color(0xFFF1F5F9),
                    onPressed: (){},
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
Widget cardData({
    required String title,
    required String subtitle,
}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title,
          size: 14,
          weight: FontWeight.w400,
          color: ColorResource.gray,
        ),
        CustomText(
          subtitle,
          size: 14,
          weight: FontWeight.w400,
          color: ColorResource.black,
        )
      ],
    );
}
}
