import 'package:flutter/material.dart';
import 'package:nexwage/screen/profile/provider/profile_provider.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:provider/provider.dart';
class UpdateBankDetails extends StatefulWidget {
  const UpdateBankDetails({super.key});

  @override
  State<UpdateBankDetails> createState() => _UpdateBankDetailsState();
}

class _UpdateBankDetailsState extends State<UpdateBankDetails> {
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).getBankData();
    });
  }


  List<String> accountTypes = [
    'Current',
    'Savings',
    'Salary',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, provider, child) {
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
                          controller: provider.bankController,
                          hintText: 'Enter Bank Name',
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          'Bank Branch',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.black,
                        ),
                        CommonTextFormField(
                          controller: provider.branchNameController,
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
                          controller: provider.accountHolderNameController,
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
                          controller: provider.accountNumberController,
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
                          controller: provider.accountTypeController,
                          readOnly: true,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
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
                                        provider.accountTypeController.text = accountTypes[index];
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
                          controller: provider.ifscController,
                          hintText: 'Enter IFSC / Routing Code',
                        ),
                        SizedBox(height: 20,),
                        CommonAppButton(
                            text: 'Update Account Details',
                            backgroundColor1: ColorResource.button1,
                            backgroundColor2: ColorResource.button1,
                            isLoading: provider.isLoading,
                            onPressed: (){
                              provider.postBankAccountDetails(context);
                            }
                        )
                      ],
                    ),
                  ),
                ),
              )
          );
        }
    );
  }
}
