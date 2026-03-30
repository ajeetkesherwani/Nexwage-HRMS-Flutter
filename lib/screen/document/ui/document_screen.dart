import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'Documents'),
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  CustomText(
                    'Upload New Document',
                    size: 18,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 25),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorResource.documentColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 2,
                        color: const Color(0x4C1D4FD7),
                      )
                    ),child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: ColorResource.cloudColor,
                        ),child: Icon(Icons.cloud_upload_outlined,color: ColorResource.button1,),
                      ),
                      SizedBox(height: 10,),
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
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                            decoration: BoxDecoration(
                              color: ColorResource.white
                            ),child: Row(
                            children: [
                              Icon(
                                Icons.picture_as_pdf_outlined,
                                color: ColorResource.red,
                                size: 14,
                              ),SizedBox(width: 5,),
                              CustomText(
                                'PDF',
                                size: 10,
                                weight: FontWeight.w700,
                                color: ColorResource.black,
                              )
                            ],
                            ),
                          ),
                          SizedBox(width: 15,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                            decoration: BoxDecoration(
                                color: ColorResource.white
                            ),child: Row(
                            children: [
                              Icon(
                                Icons.image,
                                color: ColorResource.button1,
                                size: 14,
                              ),SizedBox(width: 5,),
                              CustomText(
                                'JPG/PNG',
                                size: 10,
                                weight: FontWeight.w700,
                                color: ColorResource.black,
                              )
                            ],
                          ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      CommonAppButton(
                          text: "Select File",
                          backgroundColor1: ColorResource.button1,
                          backgroundColor2: ColorResource.button1,
                          onPressed: (){}
                      ),
                      SizedBox(height: 20,),
                      CustomText(
                        'Maximum file size: 5MB',
                        size: 12,
                        weight: FontWeight.w400,
                        color: ColorResource.gray,

                      )
                    ],
                  ),
                  ),
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
                        '4 Files',
                        size: 14,
                        weight: FontWeight.w600,
                        color: ColorResource.button1,
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  documentCard(),
                ],
              ),
            ),
          ),
        )
    );
  }
  Widget documentCard(){
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
            imagePath: AppImages.announcement,
          height: 42,
          width: 42,
        ),
        SizedBox(width: 5,),
        Container(
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'PAN Card',
                size: 14,
                weight: FontWeight.w700,
                color: ColorResource.black,
              ),
              CustomText(
                'Uploaded on 12 Oct, 2023 • 1.2 MB',
                size: 12,
                weight: FontWeight.w400,
                color: ColorResource.gray,
              )
            ],
          ),
        ),
        CustomImageView(
            imagePath: AppImages.download,
          height: 15,
          width: 15,
        ),
        SizedBox(width: 10,),
        Icon(Icons.delete,color: ColorResource.gray,),
      ],
    ),
    );
  }
}
