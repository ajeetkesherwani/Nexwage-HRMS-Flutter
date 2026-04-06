import 'package:flutter/material.dart';
import 'package:nexwage/screen/profile/provider/profile_provider.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:provider/provider.dart';

import '../../../../../../util/color/app_colors.dart';
import '../../../../../../util/image_resource/image_resource.dart';
import '../../../../../../widget/commonTextFormField.dart';
import '../../../../../../widget/customImageView.dart';
import '../../../../../../widget/custom_text.dart';



class EmergencyContactEditScreen extends StatefulWidget {
  final String  id;

  const EmergencyContactEditScreen({super.key, required this.id});

  @override
  State<EmergencyContactEditScreen> createState() => _EmergencyContactEditScreenState();
}

class _EmergencyContactEditScreenState extends State<EmergencyContactEditScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController personEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).getemergencyGetByIdData( id: '${widget.id}');
    });

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
    return Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          return  SafeArea(
            top: false,
            child: Scaffold(
              appBar: CommonAppBar(title:"Edit Contact",),
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
                      labelText(title: 'Contact Name'),
                      CommonTextFormField(
                        controller: provider.nameController,
                        prefixIcon: Icons.person_2_outlined,
                        hintText: 'Enter Name',
                      ),

                      const SizedBox(height: 10),
                      labelText(title: 'Relationship'),

                      CommonTextFormField(
                        controller: provider.relationController,
                        prefixIcon: Icons.share,
                        hintText: 'Selected Relationship',
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                        readOnly: true,
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
                                        // ✅ FIX HERE
                                        provider.relationController.text = relations[index];

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
                      labelText(title: 'Phone Number'),
                      CommonTextFormField(
                        controller: provider.phoneController,
                        prefixIcon: Icons.call,
                        hintText: 'Phone Number',
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                      ),

                      const SizedBox(height: 10),
                      labelText(title: 'Person Email'),
                      CommonTextFormField(
                        prefixIcon: Icons.email_outlined,
                        controller: provider.personEmailController,
                        hintText: 'Person Email',
                      ),



                      const SizedBox(height: 30),

                      CommonAppButton(
                        text: 'Save Contact',
                        isLoading: provider.loading1,
                        onPressed: () {
                          provider.updateEmergencyContact(context, widget.id);
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
    );
  }
  Widget labelText({required String title}){
    return CustomText(
      title,
      size: 14,
      weight: FontWeight.w400,
      color: ColorResource.gray,
    );
  }
}



