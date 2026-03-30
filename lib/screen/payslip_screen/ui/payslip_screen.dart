import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
class PayslipScreen extends StatefulWidget {
  const PayslipScreen({super.key});

  @override
  State<PayslipScreen> createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {
  int selectedIndex = 0;
  final List<String> filters = [
    "All",
    "2023",
    "2022",
    "Last 6 Months",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CommonAppBar(title: 'Payslip',isBack: false,),
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorResource.button1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'LATEST PAYSLIP',
                          size: 11,
                          weight: FontWeight.w500,
                          color: ColorResource.white,
                        ),
                        CustomText(
                          'October 2023',
                          size: 16,
                          weight: FontWeight.w700,
                          color: ColorResource.white,
                        ),
                        SizedBox(height: 25,),
                        CustomText(
                          'Net Salary',
                          size: 11,
                          weight: FontWeight.w500,
                          color: ColorResource.white,
                        ),
                        CustomText(
                          '₹84,500.00',
                          size: 18,
                          weight: FontWeight.w700,
                          color: ColorResource.white,
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: ColorResource.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                imagePath: AppImages.download,
                                height: 15,
                                width: 15,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 5),
                              CustomText(
                                'Download PDF',
                                size: 16,
                                weight: FontWeight.w700,
                                color: ColorResource.button1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        'Payslip History',
                        size: 16,
                        weight: FontWeight.w700,
                        color: ColorResource.black,
                      ),
                      CustomText(
                        'View All',
                        size: 12,
                        weight: FontWeight.w700,
                        color: ColorResource.button1,
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filters.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 5),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? ColorResource.button1
                                  : ColorResource.searchBar,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                                child:
                                CustomText(
                                  filters[index],
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: isSelected
                                      ?ColorResource.white
                                      :ColorResource.grayText,
                                )
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10,),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: payShipHistory(
                          title: 'October 2023',
                          subtitle: 'Paid on 30 Sep, 2023',
                          price: '₹84,500',
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
  Widget payShipHistory({
    required String title,
    required String subtitle,
    required String price,
}){
    return Container(
      padding: EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: ColorResource.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFFF1F5F9),
          ),
          borderRadius: BorderRadius.circular(16),
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
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: ColorResource.searchBar,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: CustomImageView(
              imagePath: AppImages.file,
              height: 25,
              width: 25,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title,
              size: 14,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
            CustomText(
              subtitle,
              size: 11,
              weight: FontWeight.w400,
              color: ColorResource.gray,
            )
          ],
        ),
        SizedBox(width: 10,),
        CustomText(
          price,
          size: 14,
          weight: FontWeight.w700,
          color: ColorResource.black,
        ),
        Spacer(),
        Container(
          width: 32,
          height: 32,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: const Color(0xFFF1F5F9),
              ),
              borderRadius: BorderRadius.circular(9999),
            ),
          ),child: Icon(Icons.picture_as_pdf_outlined,color: ColorResource.button1,),
        )
      ],
    ),
    );
  }
}
