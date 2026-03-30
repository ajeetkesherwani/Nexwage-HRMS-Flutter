import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:nexwage/widget/navigator_method.dart';

import '../model/leaveModel.dart';
import '../model/recentLeaveModel.dart';
import 'apply_for_leave.dart';
class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  List<LeaveModel> leaveList = [
    LeaveModel(
      image: AppImages.sick,
      title: '08',
      subtitle: 'Sick Leave',
      color: ColorResource.button1,
      value: 0.40,
    ),
    LeaveModel(
      image: AppImages.casual,
      title: '05',
      subtitle: 'Casual Leave',
      color: ColorResource.green,
      value: 0.70,
    ),
    LeaveModel(
      image: AppImages.casual,
      title: '10',
      subtitle: 'Paid Leave',
      color: ColorResource.red,
      value: 0.50,
    ),
  ];

  List<RecentLeaveModel> recentLeaveList = [
    RecentLeaveModel(
      type: 'ANNUAL LEAVE',
      dateRange: '12 Oct - 15 Oct',
      days: '4 Days',
      appliedOn: '01 Oct',
      status: 'APPROVED',
      approvedBy: 'Sarah Sharma',
    ),
    RecentLeaveModel(
      type: 'SICK LEAVE',
      dateRange: '20 Oct - 21 Oct',
      days: '2 Days',
      appliedOn: '18 Oct',
      status: 'PENDING',
      note: 'Waiting for approval from HR Dept.',
    ),
    RecentLeaveModel(
      type: 'CASUAL LEAVE',
      dateRange: '05 Oct - 06 Oct',
      days: '2 Days',
      appliedOn: '28 Sep',
      status: 'REJECTED',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'Leave Portal',isBack: false,),
          backgroundColor: ColorResource.white,
          body: Padding(
              padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'LEAVE BALANCE',
                  size: 14,
                  weight: FontWeight.w700,
                  color: ColorResource.gray,
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 152,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: leaveList.length,
                    itemBuilder: (context, index) {
                      final data = leaveList[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: leaveCard(
                          image: data.image,
                          title: data.title,
                          subtitle: data.subtitle,
                          color: data.color,
                          value: data.value,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20,),
                CommonAppButton(
                  text:'Apply Leave',
                  backgroundColor1: ColorResource.button1,
                  backgroundColor2: ColorResource.button1,
                  onPressed: (){
                  navPush(context: context, action: ApplyForLeaveScreen());
                },image: AppImages.plus,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'RECENT APPLICATIONS',
                      size: 16,
                      weight: FontWeight.w700,
                      color: ColorResource.black,
                    ),
                    CustomText(
                      'View All',
                      size: 12,
                      weight: FontWeight.w600,
                      color: ColorResource.button1,
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                    itemCount: recentLeaveList.length,
                    itemBuilder: (context, index) {
                      final data = recentLeaveList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: recentApplicationCard(data),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
  Widget recentApplicationCard(RecentLeaveModel data) {
    Color statusColor;
    Color statusBg;

    switch (data.status) {
      case 'APPROVED':
        statusColor = ColorResource.green;
        statusBg = ColorResource.greenBackground;
        break;
      case 'PENDING':
        statusColor = ColorResource.orange;
        statusBg = ColorResource.orangeBackground;
        break;
      case 'REJECTED':
        statusColor = ColorResource.red;
        statusBg = ColorResource.redBackground;
        break;
      default:
        statusColor = Colors.grey;
        statusBg = Colors.grey.shade200;
    }

    return Container(
      padding: EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: ColorResource.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFF1F5F9)),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                data.type,
                size: 12,
                weight: FontWeight.w600,
                color: statusColor,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: statusBg,
                ),
                child: CustomText(
                  data.status,
                  size: 10,
                  weight: FontWeight.w700,
                  color: statusColor,
                ),
              )
            ],
          ),

          SizedBox(height: 10),

          /// Date
          CustomText(
            data.dateRange,
            size: 16,
            weight: FontWeight.w700,
            color: ColorResource.black,
          ),

          /// Days + Applied
          CustomText(
            '${data.days} • Applied on ${data.appliedOn}',
            size: 12,
            weight: FontWeight.w400,
            color: ColorResource.gray,
          ),

          SizedBox(height: 10),

          /// Bottom Section
          if (data.status == 'APPROVED')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Approved by ${data.approvedBy}',
                  size: 12,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ColorResource.red),
                  ),
                  child: CustomText(
                    'Withdraw',
                    size: 12,
                    weight: FontWeight.w700,
                    color: ColorResource.red,
                  ),
                )
              ],
            ),

          if (data.status == 'PENDING')
            CustomText(
              data.note ?? '',
              size: 12,
              weight: FontWeight.w400,
              color: ColorResource.gray,
            ),
        ],
      ),
    );
  }

  Widget leaveCard({
    required String image,
    required String title,
    required String subtitle,
    required Color color,
    required double value,
}){
    return Container(
      padding: EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: ColorResource.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFFF1F5F9),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
              imagePath: image,
            height: 32,
            width: 32,
          ),SizedBox(height: 10,),
          CustomText(
            title,
            size: 24,
            weight: FontWeight.w700,
            color: ColorResource.black,
          ),SizedBox(height: 10,),
          CustomText(
            subtitle,
            size: 11,
            weight: FontWeight.w400,
            color: ColorResource.gray,
          ),SizedBox(height: 10,),
          SizedBox(
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  color,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
