import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  TextEditingController endDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'Add work experience'),
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'Professional Details',
                    size: 16,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Tell us about your previous employment history.',
                    size: 14,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Company Name',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    prefixIcon: Icons.cabin_rounded,
                    hintText: 'Enter Company Name',
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Designation',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    prefixIcon: Icons.developer_board,
                    hintText: 'Enter Designation',
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Start Date',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    controller: startDateController,
                    readOnly: true,
                    prefixIcon: Icons.calendar_month,
                    hintText: 'Enter Start Date',
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

                        startDateController.text = formattedDate;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'End Date',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    controller: endDateController,
                    readOnly: true,
                    prefixIcon: Icons.calendar_month,
                    hintText: 'Enter End Date',
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

                        endDateController.text = formattedDate;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Key Responsibilities',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    hintText: 'Enter Key Responsibilities',
                    maxLines: 5,
                  ),
                  SizedBox(height: 20,),
                  CommonAppButton(
                      text: 'Save Experience',
                      backgroundColor1: ColorResource.button1,
                      backgroundColor2: ColorResource.button1,
                      onPressed: (){}
                  ),
                  SizedBox(height: 10,),
                  CommonAppButton(
                      text: 'Cancel',
                      backgroundColor1: ColorResource.white,
                      backgroundColor2: ColorResource.white,
                      textColor: ColorResource.button1,
                      onPressed: (){}
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
