import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';

import '../../../widget/commonAppBar.dart';
class ProjectByidScreen extends StatefulWidget {
  final String title;
  final String companyName;
  const ProjectByidScreen({super.key, required this.title, required this.companyName});

  @override
  State<ProjectByidScreen> createState() => _ProjectByidScreenState();
}

class _ProjectByidScreenState extends State<ProjectByidScreen> {
  List<String> users = ["Alex M.", "Sarah K.", "Daman P."];
  String getInitials(String name) {
    List<String> parts = name.split(" ");

    if (parts.length == 1) {
      return parts[0].substring(0, 2).toUpperCase();
    }

    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
  void showAddUserDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add User"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    users.add(controller.text);
                  });
                }
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
  Color getRandomColor(int index) {
    List<Color> colors = [
      Colors.blue,
      Colors.teal,
      Colors.purple,
      Colors.orange,
      Colors.red,
    ];

    return colors[index % colors.length];
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: widget.title),
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 128,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment(0.00, 0.50),
                        end: Alignment(1.00, 0.50),
                        colors: [ColorResource.priority1, ColorResource.priority2],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                          decoration: ShapeDecoration(
                            color: ColorResource.redBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9999),
                            ),
                          ),child: CustomText(
                          'HIGH PRIORITY',
                          size: 12,
                          weight: FontWeight.w700,
                          color: ColorResource.red,
                        ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: ColorResource.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFE2E8F0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              widget.companyName ?? "",
                              size: 16,
                              weight: FontWeight.w700,
                              color: ColorResource.black,
                            ),
                            CustomImageView(
                                imagePath: AppImages.company,
                              height: 20,
                              width: 22,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                        CustomText(
                          'Enterprise HR Solution',
                          size: 14,
                          weight: FontWeight.w400,
                          color: ColorResource.gray,
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          'The Employee Portal Redesign aims to\nmodernize the internal HR system for improved\nuser experience, streamlined workflows, and\nmobile responsiveness across all departments.',
                          size: 12,
                          weight: FontWeight.w400,
                          color: ColorResource.gray,
                        ),
                        SizedBox(height: 10,),
                        Divider(
                          color: ColorResource.searchBar,
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'START DATE',
                                  size: 10,
                                  weight: FontWeight.w700,
                                  color: ColorResource.gray,
                                ),
                                CustomText(
                                  '12 Oct, 2023',
                                  size: 14,
                                  weight: FontWeight.w600,
                                  color: ColorResource.black,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'ESTIMATED END',
                                  size: 10,
                                  weight: FontWeight.w700,
                                  color: ColorResource.gray,
                                ),
                                CustomText(
                                  '12 Oct, 2023',
                                  size: 14,
                                  weight: FontWeight.w600,
                                  color: ColorResource.button1,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: ColorResource.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xffE5E7EB)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'Overall Progress',
                              size: 16,
                              weight: FontWeight.w700,
                              color: ColorResource.black,
                            ),
                            CustomText(
                              '65%',
                              size: 16,
                              weight: FontWeight.w700,
                              color: ColorResource.button1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 0.65,
                            minHeight: 10,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                ColorResource.button1
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'Phase 2 of 3',
                              size: 12,
                              weight: FontWeight.w400,
                              color: ColorResource.gray,
                            ),
                            CustomText(
                              '14 Tasks Remaining',
                              size: 12,
                              weight: FontWeight.w400,
                              color: ColorResource.gray,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        'Team Members',
                        size: 16,
                        weight: FontWeight.w700,
                        color: ColorResource.black,
                      ),
                      CustomText(
                        'View All',
                        size: 12,
                        weight: FontWeight.w700,
                        color: ColorResource.button1,
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: users.length + 1, // +1 for Add button
                      itemBuilder: (context, index) {
                        if (index == users.length) {
                          return GestureDetector(
                            onTap: showAddUserDialog,
                            child: Column(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  margin: EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 2,
                                      style: BorderStyle.solid, // dashed not native
                                    ),
                                  ),
                                  child: Icon(Icons.add, size: 30),
                                ),
                                SizedBox(height: 5),
                                CustomText(
                                  'Invite',
                                  size: 12,
                                  weight: FontWeight.w400,
                                  color: ColorResource.grayText,
                                )
                              ],
                            ),
                          );
                        }

                        String name = users[index];

                        return Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              margin: EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getRandomColor(index),
                              ),
                              child: Center(
                                child:
                                  CustomText(
                                      getInitials(name),
                                    size: 16,
                                    weight: FontWeight.w700,
                                    color: ColorResource.white,
                                  )
                              ),
                            ),
                            SizedBox(height: 5),
                            CustomText(
                              name,
                              size: 12,
                              weight: FontWeight.w400,
                              color: ColorResource.black,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  CustomText(
                    'Project Milestones',
                    size: 16,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  SizedBox(height: 10,),
                  projectMilistones(),
                ],
              ),
            ),
          ),
        )
    );
  }
  Widget projectMilistones(){
    return Row(
      children: [
        CustomImageView(
            imagePath: AppImages.bellImage,
          height: 40,
          width: 40,
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: const Color(0xFFF1F5F9),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'UI Design System',
                    size: 14,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorResource.greenBackground,
                    ),child: CustomText(
                    'DONE',
                    size: 10,
                    weight: FontWeight.w700,
                    color: ColorResource.green,
                  ),
                  )
                ],
                          ),
                CustomText(
                  'Completed on 12 Nov, 2023',
                  size: 12,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
