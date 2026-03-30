import 'package:flutter/material.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';

import '../../../util/color/app_colors.dart';
class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
     // padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: completedCard(),
        );
      },
    );
  }

  Widget completedCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // optional - for spacing
      decoration: ShapeDecoration(
        color: ColorResource.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFF1F5F9),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_circle,
              color: ColorResource.button1,
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: CustomText(
                          'Quarterly Performance Review',
                          size: 12,
                          weight: FontWeight.w700,
                          color: ColorResource.black,
                        )
                      ),
                      const SizedBox(width: 3),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: ColorResource.greenBackground,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: CustomText(
                          'COMPLETED',
                          size: 10,
                          weight: FontWeight.w400,
                          color: ColorResource.green,
                        )
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  CustomText(
                    'Approved by Sarah Sharma',
                    size: 12,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  ),

                  const SizedBox(height: 5),

                Row(
                  children: [
                    CustomImageView(
                        imagePath: AppImages.caledar,
                      height: 12,
                      width: 12,
                    ),
                    SizedBox(width: 5,),
                    CustomText(
                      'Finished on 12 Oct, 2025',
                      size: 10,
                      weight: FontWeight.w500,
                      color: ColorResource.gray,
                    )
                  ],
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
