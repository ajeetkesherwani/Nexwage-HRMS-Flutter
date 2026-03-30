import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:nexwage/widget/navigator_method.dart';

import 'application_send_screen.dart';
class FullDayScreen extends StatefulWidget {
  const FullDayScreen({super.key});

  @override
  State<FullDayScreen> createState() => _FullDayScreenState();
}

class _FullDayScreenState extends State<FullDayScreen> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  /// PICK IMAGE
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Reason / Remarks',
            size: 14,
            weight: FontWeight.w400,
            color: ColorResource.gray,
          ),
          CommonTextFormField(
            maxLines: 4,
            hintText: 'Briefly explain the reason for your leave...',
          ),
          SizedBox(height: 10,),
          CustomText(
            'Attachment (Optional)',
            size: 14,
            weight: FontWeight.w400,
            color: ColorResource.gray,
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: _showPicker,
            child: Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: _image == null
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined,
                      size: 40, color: Colors.grey),
                  const SizedBox(height: 10),
                  const Text(
                    "Click or drag to upload file",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "PDF, JPG, or PNG (Max. 5MB)",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorResource.redBackground,
            ),
            child: Row(
              children: [
                CustomImageView(
                    imagePath: AppImages.leaveimage,
                  height: 36,
                  width: 36,
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'Leave Balance',
                      size: 12,
                      weight: FontWeight.w400,
                      color: ColorResource.gray,
                    ),
                    CustomText(
                      '12 days remaining this year',
                      size: 14,
                      weight: FontWeight.w700,
                      color: ColorResource.black,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          CommonAppButton(
              text: 'Submit Leave Request',
              backgroundColor1: ColorResource.button1,
              backgroundColor2: ColorResource.button1,
              onPressed: (){
                navPush(context: context, action: ApplicationSendScreen());
              }
          )
        ],
      ),
    );
  }
}
