import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';

class ProfileImageEdit extends StatefulWidget {
  @override
  State<ProfileImageEdit> createState() => _ProfileImageEditState();
}

class _ProfileImageEditState extends State<ProfileImageEdit> {
  final TextEditingController nameController = TextEditingController();
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


  void onSave() {
    final data = {
      "name": nameController.text,
      "title": titleController.text,
      "image": selectedImage?.path
    };

    Navigator.pop(context, data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CommonAppBar(title: 'Edit Profile'),
        backgroundColor: ColorResource.white,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [


              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage:
                    selectedImage != null ? FileImage(selectedImage!) : null,
                    child: selectedImage == null
                        ? Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
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


              CommonTextFormField(
                controller: nameController,
                hintText: 'Name',
              ),

              SizedBox(height: 16),


              CommonTextFormField(
                controller: titleController,
                hintText: 'Title',
              ),

              SizedBox(height: 24),


              CommonAppButton(
                text: 'Save',
                onPressed: onSave,
              )
            ],
          ),
        ),
      ),
    );
  }
}