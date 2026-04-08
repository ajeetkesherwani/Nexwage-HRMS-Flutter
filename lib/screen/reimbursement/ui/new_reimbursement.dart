import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class NewReimbursement extends StatefulWidget {
  const NewReimbursement({super.key});

  @override
  State<NewReimbursement> createState() => _NewReimbursementState();
}

class _NewReimbursementState extends State<NewReimbursement> {

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  Future<void> selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  File? selectedImage;
  File? selectedPdf;
  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        selectedPdf = null;
      });
    }
  }

  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        selectedPdf = null;
      });
    }
  }

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedPdf = File(result.files.single.path!);
        selectedImage = null;
      });
    }
  }
  final ImagePicker _picker = ImagePicker();
  void showUploadOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  pickFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text("PDF"),
                onTap: () {
                  Navigator.pop(context);
                  pickPdf();
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
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'New Reimbursement Claim'),
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  label(title: 'Category'),
                  CommonTextFormField(
                    hintText: 'Select Category',
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp,color: ColorResource.gray,),
                    onTap: (){},
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            label(title: 'Start Date'),
                            CommonTextFormField(
                              hintText: 'dd/mm/yyyy',
                              controller: startDateController,
                              onTap: () => selectDate(startDateController),
                              prefixIcon: Icons.calendar_month,
                              readOnly: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            label(title: 'End Date'),
                            CommonTextFormField(
                              hintText: 'dd/mm/yyyy',
                              controller: endDateController,
                              onTap: () => selectDate(endDateController),
                              prefixIcon: Icons.calendar_month,
                              readOnly: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),
                  label(title: 'Total Amount'),
                  CommonTextFormField(
                    hintText: '0.0',
                  ),
                  SizedBox(height: 10,),
                  label(title: 'Detailed Expense Breakdown'),
                  CommonTextFormField(
                    maxLines: 4,
                    hintText: 'List your expenses (e.g., Flight: ₹400,  Hotel: ₹200...)',
                  ),
                  SizedBox(height: 10,),
                  label(title: 'Receipt File'),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: showUploadOptions,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorResource.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xFFCBD5E1),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorResource.searchBar,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            height: 48,
                            width: 48,
                            child: Icon(
                              Icons.cloud_upload_outlined,
                              color: ColorResource.button1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomText(
                            'Click to upload or drag and drop',
                            size: 16,
                            weight: FontWeight.w400,
                            color: ColorResource.gray,
                          ),
                          CustomText(
                            'Supporting PDF, JPG, PNG (Max 5MB each)',
                            size: 12,
                            weight: FontWeight.w400,
                            color: ColorResource.grayText,
                          ),

                          const SizedBox(height: 15),

                          if (selectedImage != null)
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    selectedImage!,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  selectedImage!.path.split('/').last,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),

                          if (selectedPdf != null)
                            Column(
                              children: [
                                const Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
                                const SizedBox(height: 8),
                                Text(
                                  selectedPdf!.path.split('/').last,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  CommonAppButton(
                      text: 'Submit Claim',
                      backgroundColor1: ColorResource.button1,
                      backgroundColor2: ColorResource.button1,
                      onPressed: (){}
                  ),


                ],
              ),
            ),
          ),
        )
    );
  }
  Widget label({
    required String title,
}){
    return CustomText(
      title,
      size: 14,
      weight: FontWeight.w400,
      color: ColorResource.gray,
    );
  }
}
