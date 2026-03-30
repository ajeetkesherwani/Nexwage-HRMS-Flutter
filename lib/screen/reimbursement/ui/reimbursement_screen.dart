import 'package:flutter/material.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/navigator_method.dart';

import '../../../util/color/app_colors.dart';
import '../../../widget/commonAppBar.dart';
import '../../../widget/custom_text.dart';
import '../model/filterItemModel.dart';
import 'new_reimbursement.dart';
class ReimbursementScreen extends StatefulWidget {
  const ReimbursementScreen({super.key});

  @override
  State<ReimbursementScreen> createState() => _ReimbursementScreenState();
}

class _ReimbursementScreenState extends State<ReimbursementScreen> {
  int selectedIndex = 0;

  final List<FilterItem> filters = [
    FilterItem(title: "All", icon: Icons.list),
    FilterItem(title: "Travel", icon: Icons.flight),
    FilterItem(title: "Food", icon: Icons.restaurant),
    FilterItem(title: "Medical", icon: Icons.local_hospital),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'Reimbursement'),
          backgroundColor: ColorResource.white,
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
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
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: const Color(0xFFE2E8F0),
                                    ),
                                    color: isSelected
                                        ? ColorResource.button1
                                        : ColorResource.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                      child:
                                      Row(
                                        children: [
                                          Icon(
                                            filters[index].icon,
                                            color: isSelected ? ColorResource.white : ColorResource.black,
                                            size: 18,
                                          ),
                                          SizedBox(width: 5),
                                          CustomText(
                                            filters[index].title,
                                            size: 14,
                                            weight: FontWeight.w500,
                                            color: isSelected
                                                ? ColorResource.white
                                                : ColorResource.black,
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'Recent Claims',
                              size: 16,
                              weight: FontWeight.w700,
                              color: ColorResource.black,
                            ),
                            CustomText(
                              'View All',
                              size: 14,
                              weight: FontWeight.w600,
                              color: ColorResource.button1,
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                    ListView.builder(
                      itemCount: 15,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ticketCard(
                            image: AppImages.announcement,
                            title: 'Client Meeting - New Delhi',
                            date: '22 Oct, 2023',
                            product: 'Food',
                            price: '₹320.50',
                            status: 'APPROVED',
                          ),
                        );
                      },
                    ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 15,
                  bottom: 15,
                  child: GestureDetector(
                    onTap: (){
                      navPush(context: context, action: NewReimbursement());
                    },
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: ColorResource.button1,
                        borderRadius: BorderRadius.circular(999)
                      ),child: Icon(Icons.add,color: ColorResource.white,),
                    ),
                  )
              )
            ],
          ),
        )
    );
  }
  Widget ticketCard({
    required String image,
    required String title,
    required String date,
    required String product,
    required String price,
    required String status,
}){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      ),child: Row(
      children: [
        CustomImageView(
            imagePath: image,
          height: 48,
          width: 48,
        ),
        SizedBox(width: 10,),
        SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title,
                size: 14,
                weight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
                color: ColorResource.black,
              ),
              SizedBox(height: 5,),
              CustomText(
                '${date} • ${product}',
                size: 12,
                weight: FontWeight.w400,
                color: ColorResource.gray,
              )
            ],
          ),
        ),
        Spacer(),
        Column(
          children: [
            CustomText(
              price,
              size: 14,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7,vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: ColorResource.searchBar,
              ),child: CustomText(
              status,
              size: 10,
              weight: FontWeight.w700,
              color: ColorResource.green,
            ),
            )
          ],
        )
      ],
    ),
    );
  }
}
