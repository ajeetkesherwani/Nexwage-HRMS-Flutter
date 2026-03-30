import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';

import '../../../model/social_profile_model.dart';
class AddEditSocialScreen extends StatefulWidget {
  final SocialProfile? profile;

  const AddEditSocialScreen({super.key, this.profile});

  @override
  State<AddEditSocialScreen> createState() => _AddEditSocialScreenState();
}

class _AddEditSocialScreenState extends State<AddEditSocialScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.profile != null) {
      nameController.text = widget.profile!.name;
      linkController.text = widget.profile!.link;
      imageController.text = widget.profile!.image;
    }
  }
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                  await _picker.pickImage(source: ImageSource.camera);

                  if (image != null) {
                    imageController.text = image.path;
                    setState(() {});
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    imageController.text = image.path;
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: widget.profile == null ? "Add Profile" : "Edit Profile"),
     backgroundColor: ColorResource.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Name',
              size: 12,
              weight: FontWeight.w400,
              color: ColorResource.gray,
            ),
            CommonTextFormField(
              controller: nameController,
              hintText: 'Enter Name',
            ),
            SizedBox(height: 10,),
            CustomText(
              'Profile Link',
              size: 12,
              weight: FontWeight.w400,
              color: ColorResource.gray,
            ),
            CommonTextFormField(
              controller: linkController,
              hintText: 'Profile Link',
            ),
            SizedBox(height: 10,),
            CustomText(
              'Image Path',
              size: 12,
              weight: FontWeight.w400,
              color: ColorResource.gray,
            ),
            CommonTextFormField(
              controller: imageController,
              hintText: 'Image Path',
              onTap: (){
                pickImage(context);
              },
            ),

            SizedBox(height: 20),
            CommonAppButton(
                text: 'Save',
              onPressed: () {
                final data = SocialProfile(
                  name: nameController.text,
                  link: linkController.text,
                  image: imageController.text,
                );

                Navigator.pop(context, data);
              },
            )
          ],
        ),
      ),
    );
  }
}