import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../../../widget/commonTextFormField.dart';
import '../../profile/provider/profile_provider.dart';
import 'package:intl/intl.dart';

String formatDate(String isoDate) {
  if (isoDate.isEmpty) return "";
  try {
    final dateTime = DateTime.parse(isoDate);
    final formatter = DateFormat('dd MMM, yyyy'); // 15 Oct, 2023
    return formatter.format(dateTime);
  } catch (e) {
    return isoDate;
  }
}
class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
TextEditingController documentTitleController =TextEditingController();
TextEditingController documentTypeController =TextEditingController();
TextEditingController expiryDateController =TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).documnetMasterApiData();
      Provider.of<ProfileProvider>(context, listen: false).getAllDocument();
    });
  }

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
Future<void> _selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
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

    setState(() {
      expiryDateController.text = formattedDate;
    });
  }
}
int? selectedDocumentId;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child){
          final documentTypes = profileProvider.documentMasterModel?.data?.documentTypes ?? [];
          return SafeArea(
              top: false,
              child: Scaffold(
                appBar: CommonAppBar(title: 'Documents'),
                backgroundColor: ColorResource.white,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CustomText(
                            'Upload New Document',
                            size: 18,
                            weight: FontWeight.w600,
                            color: ColorResource.black,
                          ),
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
                        labelText(title: 'Document Title'),
                        CommonTextFormField(
                          controller: documentTitleController,
                          hintText: 'Document Title',
                        ),
                        SizedBox(height: 10,),
                        labelText(title: 'Document Type ID'),
                        CommonTextFormField(
                          controller: documentTypeController,
                          hintText: 'Document Type',
                          suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                          readOnly: true,
                          onTap: () {
                            final documentTypes = profileProvider.documentMasterModel?.data?.documentTypes ?? [];
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
                                        documentTypeController.text = doc.name ?? "";
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
                        labelText(title: 'Expiry Date'),
                        CommonTextFormField(
                          prefixIcon: Icons.calendar_month,
                          controller: expiryDateController,
                          hintText: 'Expiry Date',
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                        SizedBox(height: 10,),
                        CommonAppButton(
                          backgroundColor1: ColorResource.button1,
                            backgroundColor2: ColorResource.button1,
                            text: 'Save',
                            isLoading: profileProvider.isLoading ,
                            onPressed: () async{
                              print("document_title => ${documentTitleController.text.trim()}");
                              print(" document_type_id => ${selectedDocumentId.toString()}");
                              print(" expiry_date => ${expiryDateController.text.trim()}");
                              print("selectedFile => ${selectedFile?.path}");
                              await profileProvider.documentDataPost(
                                document_title: documentTitleController.text.trim(),
                                document_type_id: selectedDocumentId.toString(),
                                expiry_date: expiryDateController.text.trim(),
                                document_file: selectedFile,
                              );
                              if (profileProvider.isLoading == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Document uploaded successfully "),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            }
                        ),
                        SizedBox(height: 10,),




                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'My Documents',
                              size: 18,
                              weight: FontWeight.w600,
                              color: ColorResource.black,
                            ),
                            CustomText(
                              '${profileProvider.getDocumentDataModel?.data?.length} Files',
                              size: 14,
                              weight: FontWeight.w600,
                              color: ColorResource.button1,
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                  Builder(
                    builder: (context) {
                      final documentList = profileProvider.getDocumentDataModel?.data ?? [];

                      if (documentList.isEmpty) {
                        return Center(
                          child: Text(
                            "No documents available",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                      String formatDate(String? isoDate) {
                        if (isoDate == null || isoDate.isEmpty) return "";
                        try {
                          final dateTime = DateTime.parse(isoDate);
                          final formatter = DateFormat('dd MMM, yyyy'); // Example: 15 Oct, 2023
                          return formatter.format(dateTime);
                        } catch (e) {
                          return isoDate;
                        }
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: documentList.length,
                        itemBuilder: (context, index) {
                          final docData = documentList[index];

                          return documentCard(
                            date: formatDate(docData.updatedAt),
                            title: docData.documentTitle ?? "",
                            onTapDownload: () async {

                              print("Downloading ${docData.id}");
                            },
                            // onTapDelete: () async {
                            //   print("Deleting ");
                            //   print(docData.id);
                            //
                            //   if (docData.id != null) {
                            //     print("Deleting document with ID: ${docData.id}");
                            //
                            //     // Call provider to delete document
                            //     await context.read<ProfileProvider>().deleteDocument(id: "${docData.id}");
                            //
                            //     // Optional: show a snackbar for feedback
                            //     final result = context.read<ProfileProvider>().documentDeleteModel;
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(content: Text(result?.message ?? 'Action completed')),
                            //     );
                            //   }
                            // },
                            onTapDelete: () async {
                              final docId = docData.id;
                              if (docId == null) return;

                              print("Clicked delete for document ID: $docId");

                              // Show confirmation dialog
                              final confirmDelete = await showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Delete Document"),
                                    content: Text("Are you sure you want to delete this document?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false); // User cancels
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true); // User confirms
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );

                              // If user pressed OK, delete the document
                              if (confirmDelete == true) {
                                print("Deleting document with ID: $docId");

                                // Call provider to delete
                                await context.read<ProfileProvider>().deleteDocument(id: docId.toString());

                                // Show feedback
                                final result = context.read<ProfileProvider>().documentDeleteModel;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(result?.message ?? 'Document deleted successfully')),
                                );



                              } else {
                                print("Delete cancelled by user");
                              }
                            },
                          );
                        },
                      );
                    },
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
  Widget documentCard({
  required VoidCallback  onTapDownload,
  required VoidCallback    onTapDelete,
    required String title,
    required String date
}){
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFFE2E8F0),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),child: Row(
      children: [
        CustomImageView(
            imagePath: AppImages.fileBlue,
          height: 42,
          width: 30,
        ),
        SizedBox(width: 5,),
        Container(
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title,
                size: 14,
                weight: FontWeight.w700,
                color: ColorResource.black,
              ),
              CustomText(
                'Uploaded on ${date}',
                size: 12,
                weight: FontWeight.w400,
                color: ColorResource.gray,
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: onTapDownload,
          child: CustomImageView(
              imagePath: AppImages.download,
            height: 15,
            width: 15,
          ),
        ),
        SizedBox(width: 10,),
        GestureDetector(onTap: onTapDelete,
            child: Icon(Icons.delete,color: ColorResource.gray,)),
      ],
    ),
    );
  }

  Widget labelText({required String title}){
    return CustomText(
      title,
      size: 14,
      weight: FontWeight.w400,
      color: ColorResource.gray,
    );
  }
}
