import 'package:flutter/material.dart';
import 'package:nexwage/screen/profile/ui/tap_pages/general_pages/social_profile_edit.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:nexwage/widget/navigator_method.dart';
import 'package:provider/provider.dart';

import '../../../../add_qualification/ui/add_qualification.dart';
import '../../../../change_password/ui/change_password.dart';
import '../../../../document/ui/document_screen.dart';
import '../../../../update_bank_details/ui/update_bank_details.dart';
import '../../../../work_experience/ui/work_experience.dart';
import '../../../model/emergency_model.dart';
import '../../../model/social_profile_model.dart';
import '../../../provider/profile_provider.dart';
import 'basicInfo_edit_page.dart';
import 'emergency_contact.dart';
class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).getProfileData();
    });
  }
  List<SocialProfile> socialProfiles = [];
  EmergencyModel? emergencyData;
  List<EmergencyModel> emergencyList = [];
  Map<String, String> userData = {
    "name": "",
    "dob": "",
    "marital": "",
    "gender": "",
    "phone": "",
    "blood": "",
    "email": "",
    "address": "",
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: ColorResource.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Row(
                      children: [
                        Icon(Icons.person_2_outlined, color: ColorResource.button1),
                        SizedBox(width: 8),
                        CustomText(
                          'Basic Info',
                          size: 16,
                          weight: FontWeight.w600,
                        ),
                        Spacer(),


                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BasicInfoEditPage(data: userData),
                              ),
                            );

                            if (result != null) {
                              setState(() {
                                userData = result;
                              });
                            }
                          },
                          child: CustomText(
                            'Edit',
                            size: 14,
                            weight: FontWeight.w600,
                            color: ColorResource.button1,
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 10),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //titleCard("Full Name", userData["name"]),
                            titleCard("Full Name", profileProvider.getProfileModel?.data?.fullName ?? ""),
                            titleCard("DOB", profileProvider.getProfileModel?.data?.dateOfBirth ?? ""),
                            titleCard("Marital Status", userData["marital"]),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleCard("Gender", profileProvider.getProfileModel?.data?.gender ?? ""),
                            titleCard("Phone", profileProvider.getProfileModel?.data?.phone ?? ""),
                            titleCard("Blood Group", userData["blood"]),
                          ],
                        ),
                      ],
                    ),

                    titleCard("Email", profileProvider.getProfileModel?.data?.email ?? ""),
                    titleCard("Address", userData["address"]),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: AppImages.emregence,
                          height: 18,
                          width: 24,
                        ),
                        const SizedBox(width: 5),
                        CustomText(
                          'Emergency Contact',
                          size: 16,
                          weight: FontWeight.w700,
                          color: ColorResource.black,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EmergencyContact(),
                              ),
                            );

                            if (result != null && result is EmergencyModel) {
                              setState(() {
                                emergencyList.add(result);
                              });
                            }
                          },
                          child: CustomText(
                            'Add',
                            size: 14,
                            weight: FontWeight.w600,
                            color: ColorResource.button1,
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 10),

                    // if (emergencyData != null)
                    //   emergencyCard()
                    // else
                    //   CustomText(
                    //     'No contact added'
                    //   )
                    if (emergencyList.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: emergencyList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: emergencyCard(emergencyList[index], index),
                          );
                        },
                      )
                    else
                      CustomText('No contact added')
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.share,color: ColorResource.button1,),
                        SizedBox(width: 5,),
                        CustomText(
                          'Social Profile',
                          size: 16,
                          weight: FontWeight.w600,
                          color: ColorResource.black,
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        ...socialProfiles.map((profile) {
                          return GestureDetector(
                            onTap: () async {
                              final updated = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddEditSocialScreen(profile: profile),
                                ),
                              );

                              if (updated != null) {
                                setState(() {
                                  int index = socialProfiles.indexOf(profile);
                                  socialProfiles[index] = updated;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: ColorResource.searchBar,
                                  ),
                                  child: CustomImageView(
                                    imagePath: profile.image,
                                    height: 23,
                                    width: 23,
                                  ),
                                ),
                                CustomText(
                                  profile.name,
                                  size: 10,
                                )
                              ],
                            ),
                          );
                        }).toList(),

                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () async {
                            final newProfile = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddEditSocialScreen(),
                              ),
                            );

                            if (newProfile != null) {
                              setState(() {
                                socialProfiles.add(newProfile);
                              });
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: ColorResource.searchBar,
                                ),
                                child: Icon(Icons.add, color: ColorResource.gray),
                              ),
                              CustomText(
                                'Add',
                                size: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),child: Column(
                children: [
                  Row(
                    children: [
                      CustomImageView(
                        imagePath:AppImages.fileBlue,
                        height: 23,
                        width: 20,
                      ),
                      SizedBox(width: 5,),
                      CustomText(
                        'Documents',
                        size: 16,
                        weight: FontWeight.w600,
                        color: ColorResource.black,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          navPush(context: context, action: DocumentScreen());
                        },
                        child: CustomText(
                          'Upload',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.button1,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFFF1F5F9),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.file_copy_rounded,color: ColorResource.gray,),
                        SizedBox(width: 5,),
                        CustomText(
                          'PAN Card',
                          size: 14,
                          weight: FontWeight.w400,
                          color: ColorResource.black,
                        ),
                        Spacer(),
                        CustomImageView(
                          imagePath: AppImages.download,
                          height: 18,
                          width: 18,

                        )
                      ],
                    ),
                  )
                ],
              ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: AppImages.qualification,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 5,),
                      CustomText(
                        'Qualification',
                        size: 16,
                        weight: FontWeight.w700,
                        color: ColorResource.black,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          navPush(context: context, action: AddQualification());
                        },
                        child: CustomText(
                          'Add',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.button1,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'MBA in Human Resources',
                    size: 14,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  CustomText(
                    'TechCorp Solutions • 2015 - 2018',
                    size: 12,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  )
                ],
              ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: AppImages.work,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 5,),
                      CustomText(
                        'Work Experience',
                        size: 16,
                        weight: FontWeight.w700,
                        color: ColorResource.black,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          navPush(context: context, action: WorkExperience());
                        },
                        child: CustomText(
                          'Add',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.button1,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'HR Manager',
                    size: 14,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  CustomText(
                    'TechCorp Solutions • 2015 - 2018',
                    size: 12,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  )
                ],
              ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: AppImages.bank,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 5,),
                      CustomText(
                        'Bank Account',
                        size: 16,
                        weight: FontWeight.w700,
                        color: ColorResource.black,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          navPush(context: context, action: UpdateBankDetails());
                        },
                        child: CustomText(
                          'Edit',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.button1,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'Bank Name',
                            size: 12,
                            weight: FontWeight.w400,
                            color: ColorResource.gray,
                          ),
                          CustomText(
                            'BOI',
                            size: 14,
                            weight: FontWeight.w700,
                            color: ColorResource.black,
                          ),

                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'Account No',
                            size: 12,
                            weight: FontWeight.w400,
                            color: ColorResource.gray,
                          ),
                          CustomText(
                            '**** 5678',
                            size: 14,
                            weight: FontWeight.w700,
                            color: ColorResource.black,
                          ),

                        ],
                      )
                    ],
                  )
                ],
              ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: AppImages.changePassword,
                        height: 26,
                        width: 20,
                      ),
                      SizedBox(width: 5,),
                      CustomText(
                        'Change Password',
                        size: 16,
                        weight: FontWeight.w700,
                        color: ColorResource.black,
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'New Password',
                    size: 10,
                    weight: FontWeight.w400,
                    color: ColorResource.gray,
                  ),
                  CommonTextFormField(
                    obscureText: true,
                    hintText: 'Enter New Password',

                  ),
                  SizedBox(height: 10,),
                  CommonAppButton(text: 'Update Password', onPressed: (){
                    navPush(context: context, action: ChangePassword());
                  })
                ],
              ),
              ),


            ],
          );
        }
    );
  }

  Widget emergencyCard(EmergencyModel data, int index) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: ColorResource.searchBar,
          ),
          child: Icon(Icons.person_2_outlined, color: ColorResource.gray),
        ),

        SizedBox(width: 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data.name,
              size: 14,
              weight: FontWeight.w600,
              color: ColorResource.black,
            ),
            CustomText(
              '${data.relation} • ${data.phone}',
              size: 12,
              weight: FontWeight.w400,
              color: ColorResource.gray,
            )
          ],
        ),

        Spacer(),

        /// ✅ EDIT
        GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EmergencyContact(
                  emergencyData: data,
                ),
              ),
            );

            if (result != null && result is EmergencyModel) {
              setState(() {
                emergencyList[index] = result; // ✅ update specific item
              });
            }
          },
          child: CustomText(
            'Edit',
            size: 14,
            weight: FontWeight.w600,
            color: ColorResource.button1,
          ),
        )
      ],
    );
  }

  Widget titleCard(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(title, size: 10, color: ColorResource.gray),

          CustomText(
            (value == null || value.isEmpty) ? "Null" : value,
            size: 14,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

