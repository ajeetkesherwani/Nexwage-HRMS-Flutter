import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
class NewReimbursement extends StatefulWidget {
  const NewReimbursement({super.key});

  @override
  State<NewReimbursement> createState() => _NewReimbursementState();
}

class _NewReimbursementState extends State<NewReimbursement> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'New Reimbursement Claim'),
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.flight_takeoff,color: ColorResource.button1,size: 24,),
                      SizedBox(width: 10,),
                      CustomText(
                        'Trip Details',
                        size: 18,
                        weight: FontWeight.w700,
                        color: ColorResource.black,
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  label(title: 'Trip Purpose'),
                  CommonTextFormField(
                    hintText: 'Select purpose',
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp,color: ColorResource.grayText,),
                  ),
                  SizedBox(height: 10,),
                  label(title: 'Destination'),
                  CommonTextFormField(
                    hintText: 'City or country',
                    prefixIcon: Icons.location_on_outlined,
                  ),
                  SizedBox(height: 10,),
                  label(title: 'Mode of travel'),
                  CommonTextFormField(
                    hintText: 'Select Mode',
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp,color: ColorResource.grayText,),
                  ),
                  SizedBox(height: 10,),
                  label(title: 'Departure Date'),
                  CommonTextFormField(
                    hintText: 'dd/mm/yyyy',
                  ),
                  SizedBox(height: 10,),
                  label(title: 'Return Date'),
                  CommonTextFormField(
                    hintText: 'dd/mm/yyyy',
                  ),
                  SizedBox(height: 10,),
                 Row(
                   children: [
                     Icon(Icons.account_balance,size: 24,color: ColorResource.button1,),
                     SizedBox(width: 10,),
                     CustomText(
                       'Financial Details',
                       size: 18,
                       weight: FontWeight.w700,
                       color: ColorResource.black,
                     ),

                   ],
                 ),
                  SizedBox(height: 10,),
                  label(title: 'Total Amount'),
                  CommonTextFormField(
                    hintText: '0.0',
                  ),
                  SizedBox(height: 10,),
                  label(title: 'Detailed Expense Breakdown'),
                  CommonTextFormField(
                    maxLines: 4,
                    hintText: 'List your expenses (e.g., Flight: ₹400,  Hotel: ₹200...)',
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.file_copy_sharp,size: 24,color: ColorResource.button1,),
                      SizedBox(width: 10,),
                      CustomText(
                        'Receipts',
                        size: 18,
                        weight: FontWeight.w700,
                        color: ColorResource.black,
                      ),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                    width: double.infinity,
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
                          color: ColorResource.searchBar,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Icon(Icons.cloud_upload_outlined,color: ColorResource.button1,),
                        height: 48,
                        width: 48,
                      ),
                      SizedBox(height: 10,),
                      CustomText(
                        'Click to upload or drag and drop',
                        size: 16,
                        weight: FontWeight.w400,
                        color: ColorResource.gray,
                      ),
                      CustomText(
                        'Supporting PDF, JPG, PNG (Max 5MB each)',
                        size: 12,
                        weight: FontWeight.w400,
                        color: ColorResource.grayText,
                      )
                    ],
                  ),
                  ),
                  SizedBox(height: 20,),
                  CommonAppButton(
                      text: 'Submit Claim',
                      backgroundColor1: ColorResource.button1,
                      backgroundColor2: ColorResource.button1,
                      onPressed: (){}
                  ),
                  SizedBox(height: 10,),
                  CommonAppButton(
                      text: 'Cancel',
                      backgroundColor2: ColorResource.white,
                      backgroundColor1: ColorResource.white,
                      textColor: ColorResource.gray,
                      borderColor: ColorResource.grayText,
                      onPressed: (){}
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
  Widget label({
    required String title,
}){
    return CustomText(
      title,
      size: 14,
      weight: FontWeight.w400,
      color: ColorResource.gray,
    );
  }
}
