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
import 'package:url_launcher/url_launcher.dart';

import '../../../../add_qualification/ui/add_qualification.dart';
import '../../../../change_password/ui/change_password.dart';
import '../../../../document/ui/document_screen.dart';
import '../../../../update_bank_details/ui/update_bank_details.dart';
import '../../../../work_experience/ui/work_experience.dart';
import '../../../model/emergency_get_all_data_model.dart';
import '../../../model/emergency_model.dart';
import '../../../model/social_profile_model.dart';
import '../../../provider/profile_provider.dart';
import 'basicInfo_edit_page.dart';
import 'edit_pages/emergency_edit_screen.dart';
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
      Provider.of<ProfileProvider>(context, listen: false).getemergencyGetAllData();
      Provider.of<ProfileProvider>(context, listen: false).getAllDocument();
      Provider.of<ProfileProvider>(context, listen: false).getAllQualification();
      Provider.of<ProfileProvider>(context, listen: false).getAllexperence();
      Provider.of<ProfileProvider>(context, listen: false).getBankData();
      Provider.of<ProfileProvider>(context, listen: false).getAllexperence();
    });
  }
  List<SocialProfile> socialProfiles = [];

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

  Future<void> openSocialLink(String? url, BuildContext context) async {
    if (url == null || url.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Link not available")),
      );
      return;
    }

    String finalUrl = url.trim();

    // If user saved only username or incomplete link, add https
    if (!finalUrl.startsWith('http://') && !finalUrl.startsWith('https://')) {
      finalUrl = 'https://$finalUrl';
    }

    final Uri uri = Uri.parse(finalUrl);

    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // opens in app/browser
      );

      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open link")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid or unsupported link")),
      );
    }
  }
  String maskAccountNumber(String accountNumber) {
    if (accountNumber.isEmpty) return "";

    if (accountNumber.length <= 4) {
      return accountNumber;
    }

    String last4 = accountNumber.substring(accountNumber.length - 4);
    String masked = "*" * (accountNumber.length - 4);

    return "$masked$last4";
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return Column(
            children: [
              //Basic Info
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
                          onTap: (){
                            navPush(context: context, action: BasicInfoEditPage());
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
                            titleCard("Full Name", profileProvider.getProfileModel?.data?.fullName ?? ""),
                            titleCard("DOB", profileProvider.getProfileModel?.data?.dateOfBirth ?? ""),
                            titleCard("Marital Status", profileProvider.getProfileModel?.data?.maritalStatus ?? ""),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleCard("Gender", profileProvider.getProfileModel?.data?.gender ?? ""),
                            titleCard("Phone", profileProvider.getProfileModel?.data?.phone ?? ""),
                            titleCard("Blood Group", profileProvider.getProfileModel?.data?.bloodGrp ?? ""),
                          ],
                        ),
                      ],
                    ),
                    titleCard("Email", profileProvider.getProfileModel?.data?.email ?? ""),
                    titleCard("Address", profileProvider.getProfileModel?.data?.address ?? ""),
                  ],
                ),
              ),
              SizedBox(height: 10),
              //Emergency Contact
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
                            if (result != null && result is EmergencyContactData) {
                              setState(() {
                                profileProvider
                                    .emergencyGetAllDataModel!
                                    .data!
                                    .add(result);
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
                    (profileProvider.emergencyGetAllDataModel?.data?.isNotEmpty ?? false)
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                     // itemCount: profileProvider.emergencyGetAllDataModel?.data?.length ?? 0,
                      itemCount: (profileProvider.emergencyGetAllDataModel?.data?.length ?? 0).clamp(0, 2),
                      itemBuilder: (context, index) {
                        final item = profileProvider
                            .emergencyGetAllDataModel
                            ?.data?[index];



                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: emergencyCard(item!, index),
                        );
                      },
                    )
                        : CustomText('No contact added'),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              //Social Profile
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        socialProfile(
                          name: 'Facebook',
                          onTap: () {
                            openSocialLink(
                              profileProvider.getProfileModel?.data?.fbId,
                              context,
                            );
                          },
                        ),

                        socialProfile(
                          name: 'Twitter',
                          onTap: () {
                            openSocialLink(
                              profileProvider.getProfileModel?.data?.twitterId,
                              context,
                            );
                          },
                        ),

                        socialProfile(
                          name: 'LinkedIn',
                          onTap: () {
                            openSocialLink(
                              profileProvider.getProfileModel?.data?.linkedInId,
                              context,
                            );
                          },
                        ),

                        socialProfile(
                          name: 'WhatsApp',
                          onTap: () {
                            openSocialLink(
                              profileProvider.getProfileModel?.data?.whatsappId,
                              context,
                            );
                          },
                        ),

                        socialProfile(
                          name: 'Skype',
                          onTap: () {
                            openSocialLink(
                              profileProvider.getProfileModel?.data?.skypeId,
                              context,
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: (){
                            navPush(context: context, action: AddEditSocialScreen());
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
              //Document
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    // Header row with icon, title, and upload button
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: AppImages.fileBlue,
                          height: 23,
                          width: 20,
                        ),
                        const SizedBox(width: 5),
                        CustomText(
                          'Documents',
                          size: 16,
                          weight: FontWeight.w600,
                          color: ColorResource.black,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            navPush(context: context, action: DocumentScreen());
                          },
                          child: CustomText(
                            'Upload',
                            size: 14,
                            weight: FontWeight.w600,
                            color: ColorResource.button1,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Null-safe ListView for documents
                    Builder(
                      builder: (context) {
                        final documentList =
                            profileProvider.getDocumentDataModel?.data ?? [];

                        if (documentList.isEmpty) {
                          return Center(
                            child: CustomText(
                              "No documents available",
                              size: 14,
                              weight: FontWeight.w400,
                              color: ColorResource.gray,
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          //itemCount: documentList.length ,
                          itemCount:2 ,
                          itemBuilder: (context, index) {
                            final docData = documentList[index];

                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0xFFF1F5F9),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.file_copy_rounded, color: ColorResource.gray),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: CustomText(
                                      docData.documentTitle ?? "N/A",
                                      size: 14,
                                      weight: FontWeight.w400,
                                      color: ColorResource.black,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Handle download or tap action here
                                      print('Tapped download for ${docData.documentFile}');
                                    },
                                    child: CustomImageView(
                                      imagePath: AppImages.download,
                                      height: 18,
                                      width: 18,
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              //Qualification
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
                  Builder(
                      builder: (context) {
                        final educationList =
                            profileProvider.qualificationGetDataModel?.data ?? [];

                        if (educationList.isEmpty) {
                          return Center(
                            child: CustomText(
                              "No Qualification available",
                              size: 14,
                              weight: FontWeight.w400,
                              color: ColorResource.gray,
                            ),
                          );
                        }

                        return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                       // itemCount: educationList.length,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          final item = educationList[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  item.institutionName ?? '',
                                  size: 14,
                                  weight: FontWeight.w700,
                                  color: ColorResource.black,
                                ),
                                const SizedBox(height: 4),
                                CustomText(
                                  "${item.educationLevel?.name ?? ""} - ${item.fromYear?.split('-').last}",
                                  size: 12,
                                  weight: FontWeight.w400,
                                  color: ColorResource.gray,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  ),

                ],
              ),
              ),
              SizedBox(height: 10,),
              //Work Experience
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
                  Builder(
                      builder: (context) {
                        final experienceList =
                            profileProvider.experienceGetAllDataModel?.data ?? [];

                        if (experienceList.isEmpty) {
                          return Center(
                            child: CustomText(
                              "No Experience available",
                              size: 14,
                              weight: FontWeight.w400,
                              color: ColorResource.gray,
                            ),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                         // itemCount: experienceList.length,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            final item = experienceList[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                   item.post ?? "",
                                    size: 14,
                                    weight: FontWeight.w700,
                                    color: ColorResource.black,
                                  ),
                                  CustomText(
                                    "${item.companyName ?? ""} • ${item.fromYear?.split('-').last} - ${item.toYear?.split('-').last} ",
                                    //'TechCorp Solutions • 2015 - 2018',
                                    size: 12,
                                    weight: FontWeight.w400,
                                    color: ColorResource.gray,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                  ),
                ],
              ),
              ),
              SizedBox(height: 10,),
              //Bank Account
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
                            profileProvider.getBankAccountModel?.data?.bankName ?? "",
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
                            maskAccountNumber(
                              profileProvider.getBankAccountModel?.data?.accountNumber ?? "",
                            ),
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
              //Change Password
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
  Widget emergencyCard(EmergencyContactData data, int index) {
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
              data.contactName ?? "",
              size: 14,
              weight: FontWeight.w600,
              color: ColorResource.black,
            ),
            CustomText(
              '${data.relation ?? ''} • ${data.personalPhone ?? ''}',
              size: 12,
              weight: FontWeight.w400,
              color: ColorResource.gray,
            ),
          ],
        ),

        Spacer(),

        GestureDetector(
          onTap: () async {
           navPush(context: context, action: EmergencyContactEditScreen(
             id: data.id.toString(),
           ));


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
            (value == null || value.isEmpty) ? "N/A" : value,
            size: 14,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget socialProfile({
    required String name,
    required VoidCallback onTap,
}){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: ColorResource.searchBar,
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Icon(Icons.link, color: ColorResource.gray),
          ),
        ),
        CustomText(
          name,
          size: 10,
        )
      ],
    );
  }
}

