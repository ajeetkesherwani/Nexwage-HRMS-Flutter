import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexwage/screen/leave_screen/provider/leave_provider.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../util/image_resource/image_resource.dart';
import '../../../widget/commonAppButton.dart';
import '../../../widget/customImageView.dart';
import '../../../widget/custom_calender.dart';
import '../../../widget/navigator_method.dart';
import 'application_send_screen.dart';
class ApplyForLeaveScreen extends StatefulWidget {
  const ApplyForLeaveScreen({super.key});

  @override
  State<ApplyForLeaveScreen> createState() => _ApplyForLeaveScreenState();
}

class _ApplyForLeaveScreenState extends State<ApplyForLeaveScreen> {
  TextEditingController leaveController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController reastionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<LeaveProvider>(context, listen: false).getLeaveTypeData();
    });
  }
  DateTimeRange? selectedDateRange;

  File? _image;

  final ImagePicker _picker = ImagePicker();

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
  String? selectedLeaveTypeId;
  var selectedLeaveObj;
  bool get isHalfDayAllowed {
    return selectedLeaveObj?.allowHalfDay == true;
  }
  int selectedTab = 0;
  String? selectedLeave;

  DateTime? startDate;
  DateTime? endDate;
  DateTime focusedDay = DateTime.now();
  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
  bool isInRange(DateTime day) {
    if (startDate == null || endDate == null) return false;
    return day.isAfter(startDate!) && day.isBefore(endDate!);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveProvider>(
        builder: (context, leaveProvider, child) {
          return SafeArea(
              top: false,
              child: Scaffold(
                appBar: CommonAppBar(title: 'Apply for leave'),
                backgroundColor: ColorResource.white,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'Leave Type',
                          size: 14,
                          weight: FontWeight.w400,
                          color: ColorResource.gray,
                        ),

                        CommonTextFormField(
                          controller: leaveProvider.leaveController,
                          hintText: 'Select leave type',
                          readOnly: true,
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                          onTap: () {
                            final leaveList = leaveProvider.getLeaveTypeModel?.data ?? [];

                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ListView.builder(
                                  itemCount: leaveList.length,
                                  itemBuilder: (context, index) {
                                    final leave = leaveList[index];

                                    return ListTile(
                                      title: Text(leave.leaveType ?? ""),
                                      onTap: () {
                                        // ✅ Store NAME for UI
                                        leaveProvider.leaveController.text =
                                            leave.leaveType ?? "";

                                        // ✅ Store ID for API
                                        leaveProvider.selectedLeaveTypeId =
                                            leave.id.toString();

                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          'Selected Date',
                          size: 14,
                          weight: FontWeight.w400,
                          color: ColorResource.gray,
                        ),

                        CommonTextFormField(
                          controller: leaveProvider.dateController,
                          prefixIcon: Icons.calendar_today,
                          hintText: 'Select date',
                          readOnly: true,
                          onTap: () async {
                            final result = await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return CustomCalendarBottomSheet();
                              },
                            );

                            if (result != null) {
                              final start = result['startDate'] as DateTime;
                              final end = result['endDate'] as DateTime;

                              setState(() {
                                startDate = start;
                                endDate = end;

                                leaveProvider.dateController.text =
                                "${formatDate(start)} - ${formatDate(end)}";

                                print('Checkkck===${   leaveProvider.dateController.text}');
                                print('Checkkck===${ formatDate(start)}');
                                print('Checkkck===${ formatDate(startDate!)}');
                                print('Checkkck===${startDate}');
                                print('Checkkck===${ formatDate(end)}');
                              });
                            }
                          },
                        ),

                        SizedBox(height: 10,),
                        CustomText(
                          'Session',
                          size: 14,
                          weight: FontWeight.w400,
                          color: ColorResource.gray,
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: ColorResource.holidaysColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [

                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTab = 0;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: selectedTab == 0
                                          ? ColorResource.white
                                          : ColorResource.holidaysColor,
                                    ),
                                    child: CustomText(
                                      "Full Day",
                                      size: 14,
                                      weight: FontWeight.w600,
                                      color: selectedTab == 0
                                          ? ColorResource.orange
                                          : ColorResource.grayText,
                                    ),
                                  ),
                                ),
                              ),

                              /// SHOW ONLY IF HALF DAY ALLOWED
                              if (isHalfDayAllowed) ...[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTab = 1;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: selectedTab == 1
                                            ? ColorResource.white
                                            : ColorResource.holidaysColor,
                                      ),
                                      child: CustomText(
                                        "First Half",
                                        size: 14,
                                        weight: FontWeight.w600,
                                        color: selectedTab == 1
                                            ? ColorResource.orange
                                            : ColorResource.grayText,
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTab = 2;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: selectedTab == 2
                                            ? ColorResource.white
                                            : ColorResource.holidaysColor,
                                      ),
                                      child: CustomText(
                                        "Second Half",
                                        size: 14,
                                        weight: FontWeight.w600,
                                        color: selectedTab == 2
                                            ? ColorResource.orange
                                            : ColorResource.grayText,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                  
                        CustomText(
                          'Reason / Remarks',
                          size: 14,
                          weight: FontWeight.w400,
                          color: ColorResource.gray,
                        ),
                        CommonTextFormField(
                          maxLines: 4,
                          controller: reastionController,
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
                            onPressed: () async {
                              final provider = Provider.of<LeaveProvider>(context, listen: false);

                              print('buttonStart====${formatDate(startDate!)}');
                              await provider.applyLeaveData(
                                leave_type_id: leaveProvider.selectedLeaveTypeId.toString(),
                                start_date: formatDate(startDate!),
                                end_date: formatDate(endDate!),
                                reason: reastionController.text.trim(),
                                is_half_day: selectedTab != 0,
                                attachment: _image,
                              );

                              if (provider.loading) {
                                navPush(context: context, action: ApplicationSendScreen());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text( "Error")),
                                );
                              }
                            }
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

