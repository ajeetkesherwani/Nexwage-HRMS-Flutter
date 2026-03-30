import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
class UpdateBankDetails extends StatefulWidget {
  const UpdateBankDetails({super.key});

  @override
  State<UpdateBankDetails> createState() => _UpdateBankDetailsState();
}

class _UpdateBankDetailsState extends State<UpdateBankDetails> {
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController bankController = TextEditingController();


  List<String> accountTypes = [
    'Savings Account',
    'Current Account',
    'Salary Account',
    'Fixed Deposit Account',
  ];
  List<String> bankList = [
    'State Bank of India',
    'HDFC Bank',
    'ICICI Bank',
    'Axis Bank',
    'Punjab National Bank',
    'Bank of Baroda',
    'Canara Bank',
    'Kotak Mahindra Bank',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'Update Bank Details'),
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'Account Information',
                    size: 20,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Please ensure the details match your bank passbook exactly to avoid payment delays.',
                    size: 14,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Bank Name',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    controller: bankController,
                    readOnly: true,
                    hintText: 'Enter Bank Name',
                    suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ListView.builder(
                            itemCount: bankList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(bankList[index]),
                                onTap: () {
                                  bankController.text = bankList[index];
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Bank Branch',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    hintText: 'Enter Bank Branch',
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Account Holder Name',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    hintText: 'Enter Account Holder Name',
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Account Number',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    obscureText: true,
                    hintText: 'Enter Account Number',
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Account Type',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    controller: accountTypeController,
                    readOnly: true,
                    suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                    hintText: 'Enter Account Type',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ListView.builder(
                            itemCount: accountTypes.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(accountTypes[index]),
                                onTap: () {
                                  accountTypeController.text = accountTypes[index];
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'IFSC / Routing Code',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CommonTextFormField(
                    hintText: 'Enter IFSC / Routing Code',
                  ),
                  SizedBox(height: 20,),
                  CommonAppButton(
                      text: 'Update Account Details',
                      backgroundColor1: ColorResource.button1,
                      backgroundColor2: ColorResource.button1,
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
