import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexwage/screen/profile/provider/profile_provider.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../model/social_profile_model.dart';
class AddEditSocialScreen extends StatefulWidget {

  const AddEditSocialScreen({super.key});

  @override
  State<AddEditSocialScreen> createState() => _AddEditSocialScreenState();
}

class _AddEditSocialScreenState extends State<AddEditSocialScreen> {
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController linkedController = TextEditingController();
  TextEditingController whatshappController = TextEditingController();
  TextEditingController skypeController = TextEditingController();


  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).getProfileData();
      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      final profile = profileProvider.getProfileModel?.data;
      if (profile != null) {
        facebookController.text = profile.fbId ?? '';
        twitterController.text = profile.twitterId ?? '';
        linkedController.text = profile.linkedInId ?? '';
        whatshappController.text = profile.whatsappId ?? '';
        skypeController.text = profile.skypeId ?? '';
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return Scaffold(
            appBar: CommonAppBar(title: "Edit Profile"),
            backgroundColor: ColorResource.white,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label(title: 'Facebook'),
                    CommonTextFormField(
                      controller: facebookController,
                      hintText: 'Facebook',
                    ),
                    SizedBox(height: 10,),
                    label(title: 'Twitter'),
                    CommonTextFormField(
                      controller: twitterController,
                      hintText: 'Twitter',
                    ),
                    SizedBox(height: 10,),
                    label(title: 'LinkedIn'),
                    CommonTextFormField(
                      controller: linkedController,
                      hintText: 'LinkedIn',

                    ),
                    SizedBox(height: 10,),
                    label(title: 'WhatsApp'),
                    CommonTextFormField(
                      controller: whatshappController,
                      hintText: 'WhatsApp',

                    ), SizedBox(height: 10,),
                    label(title: 'Skype'),
                    CommonTextFormField(
                      controller: skypeController,
                      hintText: 'Skype',

                    ),


                    SizedBox(height: 20),
                    CommonAppButton(
                      text: 'Save',
                      isLoading: profileProvider.isLoading,
                      onPressed: () async{
                        bool success =await profileProvider.postSocialLink(
                          fb_id: facebookController.text.trim(),
                          twitter_id: twitterController.text.trim(),
                          linkedIn_id: linkedController.text.trim(),
                          whatsapp_id: whatshappController.text.trim(),
                          skype_id: skypeController.text.trim(),
                        );

                        if (success) {
                          Fluttertoast.showToast(
                            msg: "Link updated successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Failed to update Link",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                      },
                    ),

                  ],
                ),
              ),
            ),
          );
        }
    );
  }
  Widget label({required String title}){
    return CustomText(
      title,
      size: 12,
      weight: FontWeight.w400,
      color: ColorResource.gray,
    );
  }
}