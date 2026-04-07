import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nexwage/screen/profile/provider/profile_provider.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
class AddQualification extends StatefulWidget {
  const AddQualification({super.key});

  @override
  State<AddQualification> createState() => _AddQualificationState();
}

class _AddQualificationState extends State<AddQualification> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController qualificationTypeController = TextEditingController();
  TextEditingController univeristyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).documnetMasterApiData();

    });
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  /// 5MB
  final int maxFileSize = 5 * 1024 * 1024;

  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text("Camera"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text("Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (picked != null) {
      final file = File(picked.path);
      final size = await file.length();

      if (size > maxFileSize) {
        _showMessage("Image size should be less than 5MB");
        return;
      }

      setState(() {
        selectedImage = file;
      });
    }
  }

  void _removeImage() {
    setState(() {
      selectedImage = null;
    });
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  int? selectedDocumentId;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, provider, child){
          return SafeArea(
              top: false,
              child: Scaffold(
                appBar: CommonAppBar(title: 'Add Qualification'),
                backgroundColor: ColorResource.white,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'DEGREE NAME',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.black,
                        ),
                        CommonTextFormField(
                          prefixIcon: Icons.school_outlined,
                          controller: qualificationTypeController,
                          hintText: 'Qualification Type',
                          suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                          readOnly: true,
                          onTap: () {
                            final documentTypes = provider.documentMasterModel?.data?.qualificationEducationLevel ?? [];
                            if (documentTypes.isEmpty) return;

                            showModalBottomSheet(
                              context: context,
                              builder: (context) => ListView.builder(
                                itemCount: documentTypes.length,
                                itemBuilder: (context, index) {
                                  final doc = documentTypes[index];
                                  return ListTile(
                                    title: Text(doc.name ?? ""),
                                    onTap: () {
                                      setState(() {
                                        qualificationTypeController.text = doc.name ??"";
                                        selectedDocumentId = doc.id;
                                      });
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          'INSTITUTION',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.black,
                        ),
                        CommonTextFormField(
                          controller: univeristyController,
                          hintText: 'e.g. Stanford University',
                          prefixIcon: Icons.account_balance,
                        ),
                        SizedBox(height: 10,),

                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Start Date',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  CommonTextFormField(
                                    hintText: 'Select Start Date',
                                    prefixIcon: Icons.calendar_today,
                                    controller: _startDateController,
                                    // suffixIcon: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
                                    onTap: () => _selectDate(context, _startDateController,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'End Date',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),

                                  CommonTextFormField(
                                    prefixIcon: Icons.calendar_today,
                                    hintText: 'Select End Date',
                                    controller: _endDateController,
                                    //  suffixIcon: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
                                    onTap: () => _selectDate(context, _endDateController,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          'CERTIFICATE ATTACHMENT',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.black,
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 2,
                                color: const Color(0xFFCBD5E1),
                              ),
                            ),
                            child: selectedImage == null
                                ? Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: const Color(0xFFF1F5F9),
                                  ),
                                  child: const Icon(
                                    Icons.cloud_upload_outlined,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Upload Certificate',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'JPG or PNG (max. 5MB)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            )
                                : Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    selectedImage!,
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: _showImagePickerOptions,
                                      child: const Text("Change"),
                                    ),
                                    TextButton(
                                      onPressed: _removeImage,
                                      child: const Text("Remove"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 50,),
                        CommonAppButton(
                            backgroundColor1: ColorResource.button1,
                            backgroundColor2: ColorResource.button1,
                            text: 'Save Qualification',
                            isLoading: provider.isLoading,
                            onPressed: (){
                              provider.qualificationPostData(
                                institution_name: univeristyController.text.trim(),
                                education_level_id: selectedDocumentId.toString(),
                                from_date: _startDateController.text.trim(),
                                to_date: _endDateController.text.trim(),
                                attachment: selectedImage,
                              );
                            }
                        ),
                        SizedBox(height: 10,),
                        CommonAppButton(
                            backgroundColor1: ColorResource.white,
                            backgroundColor2: ColorResource.white,
                            textColor: ColorResource.gray,
                            borderColor: ColorResource.grayText,
                            text: 'Cancel',
                            onPressed: (){}
                        ),
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
