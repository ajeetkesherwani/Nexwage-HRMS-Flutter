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
                child: Padding(
                    padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 20,
                      shrinkWrap: true,
                      physics:  BouncingScrollPhysics(),
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
                  ),
                    ],
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
