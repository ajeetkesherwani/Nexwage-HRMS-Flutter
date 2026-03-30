import 'package:flutter/cupertino.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:flutter/material.dart';
class CoreHrScreen extends StatefulWidget {
  const CoreHrScreen({super.key});

  @override
  State<CoreHrScreen> createState() => _CoreHrScreenState();
}

class _CoreHrScreenState extends State<CoreHrScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'Transfers',
                size: 16,
                weight: FontWeight.w700,
                color: ColorResource.black,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorResource.searchBar
                ),
                child: CustomText(
                  'HISTORICAL',
                  size: 12,
                  weight: FontWeight.w400,
                  color: ColorResource.button1,
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: ColorResource.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: const Color(0xFFE2E8F0),
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
                  imagePath: AppImages.transcation,
                height: 56,
                width: 56,
              ),
              SizedBox(height: 10,),
              CustomText(
                'Global Tech India',
                size: 16,
                color: ColorResource.black,
                weight: FontWeight.w700,
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomImageView(
                          imagePath: AppImages.sale,
                        height: 10,
                        width: 12,
                      ),
                      SizedBox(width: 5,),
                      CustomText(
                        'Sales',
                        size: 14,
                        weight: FontWeight.w400,
                        color: ColorResource.gray,
                      )
                    ],
                  ),
                  CustomText(
                    'Marketing',
                    size: 14,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  ),
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: AppImages.caledar,
                        height: 13,
                        width: 11,
                      ),
                      SizedBox(width: 5,),
                      CustomText(
                        '15 Oct 2023',
                        size: 14,
                        weight: FontWeight.w400,
                        color: ColorResource.gray,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              CommonAppButton(
                  text: 'View Letter',
                  onPressed: (){},
                backgroundColor1: ColorResource.button1,
                backgroundColor2: ColorResource.button1,
              )
            ],
          ),
          ),
          SizedBox(height: 10,),
          CustomText(
            'Promotions',
            size: 16,
            weight: FontWeight.w700,
            color: ColorResource.black,
          ), SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: ColorResource.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: const Color(0xFFE2E8F0),
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
            ),child: Row(
            children: [
              CustomImageView(
                  imagePath: AppImages.promotions,
                height: 56,
                width: 56,
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'Senior Software Engineer',
                    size: 14,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                          imagePath: AppImages.effective,
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(width: 5,),
                      CustomText(
                        'Effective: 01 Jan 2024',
                        size: 12,
                        weight: FontWeight.w400,
                        color: ColorResource.gray,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'Complaints',
                size: 16,
                weight: FontWeight.w700,
                color: ColorResource.black,
              ),
              Row(
                children: [
                  Icon(Icons.add,color: ColorResource.button1,),
                  SizedBox(width: 15,),
                  CustomText(
                    'Raise New',
                    size: 14,
                    weight: FontWeight.w400,
                    color: ColorResource.button1,
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: ColorResource.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: const Color(0xFFE2E8F0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'Workplace Noise',
                    size: 16,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    decoration: BoxDecoration(
                      color: ColorResource.orangeBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),child: CustomText(
                    'IN PROGRESS',
                    size: 10,
                    weight: FontWeight.w400,
                    color: ColorResource.orange,
                  ),
                  )
                ],
              ),
              Row(
                children: [
                  CustomImageView(
                      imagePath: AppImages.time,
                    height: 14,
                    width: 14,
                  ),
                  SizedBox(width: 5,),
                  CustomText(
                    'Submitted: 20 Oct 2023',
                    size: 12,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(12),
                  color: ColorResource.searchBar
                ),child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'FROM',
                        size: 10,
                        weight: FontWeight.w700,
                        color: ColorResource.gray,
                      ),
                      CustomText(
                        'You (Employee)',
                        size: 14,
                        weight: FontWeight.w400,
                        color: ColorResource.gray,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'TARGET',
                        size: 10,
                        weight: FontWeight.w700,
                        color: ColorResource.gray,
                      ),
                      CustomText(
                        'HR Department',
                        size: 14,
                        weight: FontWeight.w400,
                        color: ColorResource.gray,
                      )
                    ],
                  )
                ],
              ),
              ),
              SizedBox(height: 10,),
              CommonAppButton(
                  text: 'View Details',
                  onPressed: (){},
                backgroundColor1: ColorResource.white,
                backgroundColor2: ColorResource.white,
                textColor: ColorResource.button1,
                borderColor: ColorResource.button1,
              )
            ],
          ),
          ),
          SizedBox(height: 10,),
          CustomText(
            'Official Warnings',
            size: 16,
            weight: FontWeight.w700,
            color: ColorResource.black,
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorResource.white,
              border: Border(
                left: BorderSide(
                  width: 5,
                  color: ColorResource.orange
                )
              )
            ),
            child: Row(),
          )
        ],
      ),
    );
  }
}
