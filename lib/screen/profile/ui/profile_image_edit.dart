import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexwage/screen/profile/provider/profile_provider.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widget/custom_text.dart';

class ProfileImageEdit extends StatefulWidget {
  @override
  State<ProfileImageEdit> createState() => _ProfileImageEditState();
}

class _ProfileImageEditState extends State<ProfileImageEdit> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }


  void showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
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
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return SafeArea(
            top: false,
            child: Scaffold(
              appBar: CommonAppBar(title: 'Edit Profile'),
              backgroundColor: ColorResource.white,
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage:
                            selectedImage != null ? FileImage(selectedImage!) : null,
                            child: selectedImage == null
                                ? Icon(Icons.person, size: 50, color: Colors.grey)
                                : null,
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          right: 110,
                          child: GestureDetector(
                            onTap: showImagePickerOptions,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: ColorResource.button1,
                                shape: BoxShape.circle,
                              ),
                              child:
                              Icon(Icons.camera_alt, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    CustomText(
                      'First Name',
                      size: 14,
                      weight: FontWeight.w600,
                      color: ColorResource.black,
                    ),
                    CommonTextFormField(
                      controller: firstNameController,
                      hintText: 'First Name',
                    ),
                    SizedBox(height: 10,),
                    CustomText(
                      'Last Name',
                      size: 14,
                      weight: FontWeight.w600,
                      color: ColorResource.black,
                    ),
                    CommonTextFormField(
                      controller: lastNameController,
                      hintText: 'Last Name',
                    ),


                    SizedBox(height: 24),
                    CommonAppButton(
                      text: 'Save',
                      isLoading: profileProvider.isLoading,
                      onPressed: () async {
                        bool success = await profileProvider.postProfileDetails(
                          first_name: firstNameController.text.trim(),
                          last_name: lastNameController.text.trim(),
                          profile_photo: selectedImage,
                        );

                        if (success) {
                          Fluttertoast.showToast(
                            msg: "Profile updated successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Failed to update profile",
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
}