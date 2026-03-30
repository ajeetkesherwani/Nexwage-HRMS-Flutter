import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Active Projects (4)',
              size: 16,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
            CustomText(
              'Updated 2m ago',
              size: 12,
              weight: FontWeight.w400,
              color: ColorResource.gray,
            )
          ],
        ),
        SizedBox(height: 10,),
        inProgressCard(),
      ],
    );
  }
  Widget inProgressCard(){
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: ColorResource.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFFF1F5F9),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
            imagePath: AppImages.onbording2,
          width: double.infinity,
          height: 138,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ColorResource.redBackground
                    ),
                    child: CustomText(
                      'HIGH PRIORITY',
                      size: 10,
                      weight: FontWeight.w700,
                      color: ColorResource.red,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: ColorResource.searchBar
                    ),
                    child: CustomText(
                      'DUE 15 OCT',
                      size: 10,
                      weight: FontWeight.w700,
                      color: ColorResource.gray,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              CustomText(
                'Employee Onboarding - Q3',
                size: 16,
                weight: FontWeight.w700,
                color: ColorResource.black,
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  CustomImageView(
                      imagePath: AppImages.personImage,
                    height: 15,
                    width: 15,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 5,),
                  CustomText(
                    'Manager: Sarah Sharma',
                    size: 12,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'Progress',
                    size: 12,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  ),
                  CustomText(
                    '65%',
                    size: 12,
                    weight: FontWeight.w400,
                    color: ColorResource.button1,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.65,
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      ColorResource.button1
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: CommonAppButton(
                      text: "View Task Details",
                      backgroundColor1: ColorResource.button1,
                      backgroundColor2: ColorResource.button1,
                      onPressed: (){}
                  )),
                  SizedBox(width: 10,),
                  Expanded(child: CommonAppButton(
                      text: "Update Status",
                      backgroundColor1: ColorResource.button1,
                      backgroundColor2: ColorResource.button1,
                      onPressed: (){}
                  )),
                ],
              )

            ],
          ),
        )
      ],
    ),
    );
  }
}
