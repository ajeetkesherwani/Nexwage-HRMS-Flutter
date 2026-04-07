import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexwage/screen/profile/provider/profile_provider.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  TextEditingController endDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  File? selectedFile;
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  // Pick image from gallery or camera
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery); // or camera
    if (image != null) {
      setState(() {
        selectedFile = File(image.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, provider, child){
          return SafeArea(
              top: false,
              child: Scaffold(
                appBar: CommonAppBar(title: 'Add work experience'),
                backgroundColor: ColorResource.white,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'Professional Details',
                          size: 16,
                          weight: FontWeight.w700,
                          color: ColorResource.black,
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          'Tell us about your previous employment history.',
                          size: 14,
                          weight: FontWeight.w400,
                          color: ColorResource.gray,
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          'Company Name',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.black,
                        ),
                        CommonTextFormField(
                          prefixIcon: Icons.cabin_rounded,
                          controller: companyController,
                          hintText: 'Enter Company Name',
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          'Designation',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.black,
                        ),
                        CommonTextFormField(
                          prefixIcon: Icons.developer_board,
                          controller: designationController,
                          hintText: 'Enter Designation',
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          'Start Date',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.black,
                        ),
                        CommonTextFormField(
                          controller: startDateController,
                          readOnly: true,
                          prefixIcon: Icons.calendar_month,
                          hintText: 'Enter Start Date',
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  "${pickedDate.day.toString().padLeft(2, '0')}-"
                                  "${pickedDate.month.toString().padLeft(2, '0')}-"
                                  "${pickedDate.year}";

                              startDateController.text = formattedDate;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          'End Date',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.black,
                        ),
                        CommonTextFormField(
                          controller: endDateController,
                          readOnly: true,
                          prefixIcon: Icons.calendar_month,
                          hintText: 'Enter End Date',
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  "${pickedDate.day.toString().padLeft(2, '0')}-"
                                  "${pickedDate.month.toString().padLeft(2, '0')}-"
                                  "${pickedDate.year}";

                              endDateController.text = formattedDate;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorResource.documentColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(width: 2, color: const Color(0x4C1D4FD7)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  color: ColorResource.cloudColor,
                                ),
                                child: Icon(Icons.cloud_upload_outlined, color: ColorResource.button1),
                              ),
                              const SizedBox(height: 10),
                              CustomText(
                                'Drag & Drop or Click to Upload',
                                size: 16,
                                weight: FontWeight.w700,
                                color: ColorResource.black,
                              ),
                              CustomText(
                                'PAN, Aadhaar, Degree, or Work Exp.',
                                size: 12,
                                weight: FontWeight.w400,
                                color: ColorResource.gray,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: pickFile,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(color: ColorResource.white),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.picture_as_pdf_outlined, color: Colors.red, size: 14),
                                          SizedBox(width: 5),
                                          CustomText('PDF', size: 10, weight: FontWeight.w700, color: Colors.black),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  InkWell(
                                    onTap: pickImage,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(color: ColorResource.white),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.image, color: Colors.blue, size: 14),
                                          SizedBox(width: 5),
                                          CustomText('JPG/PNG', size: 10, weight: FontWeight.w700, color: Colors.black),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              CommonAppButton(
                                text: selectedFile == null ? "Select File" : "Upload File",
                                backgroundColor1: ColorResource.button1,
                                backgroundColor2: ColorResource.button1,
                                onPressed: () {
                                  if (selectedFile != null) {
                                    // Call your upload API here
                                    print('Uploading: ${selectedFile!.path}');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please select a file first')),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomText(
                                selectedFile != null ? 'Selected: ${selectedFile!.path.split('/').last}' : 'Maximum file size: 5MB',
                                size: 12,
                                weight: FontWeight.w400,
                                color: ColorResource.gray,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          'Key Responsibilities',
                          size: 14,
                          weight: FontWeight.w600,
                          color: ColorResource.black,
                        ),
                        CommonTextFormField(
                          controller: remarkController,
                          hintText: 'Enter Key Responsibilities',
                          maxLines: 5,
                        ),
                        SizedBox(height: 20,),
                        // CommonAppButton(
                        //     text: 'Save Experience',
                        //     backgroundColor1: ColorResource.button1,
                        //     backgroundColor2: ColorResource.button1,
                        //     isLoading: provider.isLoading,
                        //     onPressed: (){
                        //       provider.experiencePostData(
                        //         company_name: companyController.text.trim(),
                        //         post: designationController.text.trim(),
                        //         from_date: startDateController.text.trim(),
                        //         to_date: endDateController.text.trim(),
                        //         remark: remarkController.text.trim(),
                        //         attachment: selectedFile,
                        //       );
                        //     }
                        // ),

                        CommonAppButton(
                          text: 'Save Experience',
                          backgroundColor1: ColorResource.button1,
                          backgroundColor2: ColorResource.button1,
                          isLoading: provider.isLoading,
                          onPressed: () async {
                            final success = await provider.experiencePostData(
                              company_name: companyController.text.trim(),
                              post: designationController.text.trim(),
                              from_date: startDateController.text.trim(),
                              to_date: endDateController.text.trim(),
                              remark: remarkController.text.trim(),
                              attachment: selectedFile,
                            );

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Experience saved successfully"),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Failed to save experience"),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 10,),
                        CommonAppButton(
                            text: 'Cancel',
                            backgroundColor1: ColorResource.white,
                            backgroundColor2: ColorResource.white,
                            textColor: ColorResource.button1,
                            onPressed: (){}
                        )
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
