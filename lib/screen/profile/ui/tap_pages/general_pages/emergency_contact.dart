import 'package:flutter/material.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';

import '../../../../../util/color/app_colors.dart';
import '../../../../../util/image_resource/image_resource.dart';
import '../../../../../widget/commonTextFormField.dart';
import '../../../../../widget/customImageView.dart';
import '../../../../../widget/custom_text.dart';
import '../../../model/emergency_model.dart';

class EmergencyContact extends StatefulWidget {
  final EmergencyModel? emergencyData;

  const EmergencyContact({super.key, this.emergencyData});

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();


    if (widget.emergencyData != null) {
      nameController.text = widget.emergencyData!.name;
      relationController.text = widget.emergencyData!.relation;
      phoneController.text = widget.emergencyData!.phone;
    }
  }
  final List<String> relations = [
    "Spouse",
    "Parents",
    "Sibling",
    "Friend",
    "Other",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CommonAppBar(title:  widget.emergencyData == null ? "Add Contact" : "Edit Contact",),
      backgroundColor: ColorResource.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container( padding: EdgeInsets.all(15), width: double.infinity, decoration: BoxDecoration( borderRadius: BorderRadius.circular(12), color: ColorResource.searchBar,  ),
            child: Row( crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: AppImages.passwordUpdate,
                  height: 24, width: 24, ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomText(
                    'Provide the details of someone we can contact in case of an emergency. This information is kept strictly confidential.',
                    size: 14,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  ), ), ], ), ),
                SizedBox(height: 10,),
                CustomText(
                  'Contact Name',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                ),
                CommonTextFormField(
                  controller: nameController,
                  prefixIcon: Icons.person_2_outlined,
                  hintText: 'Enter Name',
                ),
          
                const SizedBox(height: 10),
                CustomText(
                  'Relationship',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                ),

                CommonTextFormField(
                  controller: relationController,
                  prefixIcon: Icons.share,
                  hintText: 'Selected Relationship',
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                  readOnly: true, // IMPORTANT
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(16),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: relations.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(relations[index]),
                                onTap: () {
                                  relationController.text = relations[index];
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
          
                
                const SizedBox(height: 10),
                CustomText(
                  'Phone Number',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                ),
                CommonTextFormField(
                  controller: phoneController,
                  prefixIcon: Icons.call,
                  hintText: 'Phone Number',
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                ),
                
          
                
                const SizedBox(height: 30),
                CommonAppButton(text: 'Save Contact',
                  onPressed: () {
                    final data = EmergencyModel(
                      name: nameController.text,
                      relation: relationController.text,
                      phone: phoneController.text,
                    );
          
                    Navigator.pop(context, data);
                  },
                ),
                SizedBox(height: 10,),
                CommonAppButton(
                    text: 'Cancel',
                    textColor: ColorResource.gray,
                    backgroundColor1: ColorResource.white,
                    backgroundColor2: ColorResource.white,
                    borderColor: ColorResource.button1,
                    onPressed: (){
                      Navigator.pop(context);
                    }
                ),
          
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}