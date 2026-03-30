import 'package:flutter/cupertino.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({super.key});

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorResource.button1
          ),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'ANNUAL CTC',
                        size: 12,
                        weight: FontWeight.w400,
                        color: ColorResource.white,
                      ),
                      CustomText(
                        '₹12,450',
                        size: 30,
                        weight: FontWeight.w700,
                        color: ColorResource.white,
                      )
                    ],
                  ),
                  CustomImageView(
                      imagePath: AppImages.salaryImage,
                    height: 32,
                    width: 38,
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              decoration: BoxDecoration(
                color: ColorResource.white.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)
                )
              ),child: Row(
              children: [
                CustomImageView(
                    imagePath: AppImages.calenderWhite,
                  height: 14,
                  width: 12,
                ),
                SizedBox(width: 5,),
                CustomText(
                  'Next Payout',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.white,
                ),
                Spacer(),
                CustomText(
                  '28 Oct, 2023',
                  size: 14,
                  weight: FontWeight.w700,
                  color: ColorResource.white,
                )
              ],
            ),
            )
          ],
        ),
        ),
        SizedBox(height: 10,),
        CustomText(
          'Salary Structure',
          size: 16,
          weight: FontWeight.w700,
          color: ColorResource.black,
        ),
        SizedBox(height: 10,),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: salaryCard(
                image: AppImages.announcement,
                title: 'Basic Salary ${index + 1}',
                value: '₹65,000',
              ),
            );
          },
        )
      ],
    );
  }
  Widget salaryCard({
    required String image,
    required String title,
    required String value
}){
    return Row(
      children: [
        CustomImageView(
            imagePath: image,
          height: 32,
          width: 32,
        ),
        SizedBox(width: 10,),
        CustomText(
          title,
          size: 14,
          weight: FontWeight.w400,
          color: ColorResource.black,
        ),
        Spacer(),
        CustomText(
          value,
          size: 14,
          weight: FontWeight.w700,
          color: ColorResource.black,
        )
      ],
    );
  }
}
