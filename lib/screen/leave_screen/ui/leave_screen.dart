import 'package:flutter/material.dart';
import 'package:nexwage/screen/leave_screen/provider/leave_provider.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:nexwage/widget/navigator_method.dart';
import 'package:provider/provider.dart';
import '../model/leaveModel.dart';
import 'apply_for_leave.dart';
import 'package:intl/intl.dart';
class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<LeaveProvider>(context, listen: false).getLeaveData();
      Provider.of<LeaveProvider>(context, listen: false).getwithdrawnData( id: '');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveProvider>(
        builder: (context, leaveProvider, child) {
          final leaveList = leaveProvider.getLeaveModel?.leaveSummary;
          final leaveRequestList = leaveProvider.getLeaveModel?.leaveRequests;
          return  SafeArea(
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
                        child: (leaveList == null || leaveList.isEmpty)
                            ? Center(
                          child: Text(
                            "No leave data available",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        )
                            : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: leaveList.length,
                          itemBuilder: (context, index) {
                            final data = leaveList[index];

                            final List<Color> leaveColors = [
                              Colors.blue,
                              Colors.green,
                              Colors.orange,
                              Colors.purple,
                              Colors.red,
                            ];

                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: leaveCard(
                                image: AppImages.sick,
                                title: (data.allocatedLeaves ?? 0).toString(),
                                subtitle: data.leaveTypeName ?? "N/A",
                                color: leaveColors[index % leaveColors.length],
                                value: (data.usedLeaves is num)
                                    ? (data.usedLeaves as num).toDouble()
                                    : 0.0,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        height: 40,
                        child: CommonAppButton(
                          text:'Apply Leave',
                          backgroundColor1: ColorResource.button1,
                          backgroundColor2: ColorResource.button1,
                          onPressed: (){
                            navPush(context: context, action: ApplyForLeaveScreen());
                          },image: AppImages.plus,),
                      ),
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
                    child: (leaveRequestList == null || leaveRequestList.isEmpty)
                        ? const Center(child: Text("No leave requests"))
                        : ListView.builder(
                      itemCount: leaveRequestList.length,
                      itemBuilder: (context, index) {
                        final request = leaveRequestList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: recentApplicationCard(request),
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
    );


  }


  Widget recentApplicationCard(LeaveRequests requestLeave) {
    Color statusColor;
    Color statusBg;

    switch (requestLeave.status) {
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

    int days = 0;
    String appliedDate = "";

    try {
      if (requestLeave.fromDate != null && requestLeave.toDate != null) {
        final from = DateTime.parse(requestLeave.fromDate!);
        final to = DateTime.parse(requestLeave.toDate!);
        days = to.difference(from).inDays + 1;
      }

      if (requestLeave.appliedOn != null) {
        final applied = DateTime.parse(requestLeave.appliedOn!);
        appliedDate = DateFormat('dd MMM').format(applied);
      }
    } catch (e) {
      days = 0;
      appliedDate = "";
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                requestLeave.leaveTypeName ?? "",
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
                  requestLeave.status ?? "",
                  size: 10,
                  weight: FontWeight.w700,
                  color: statusColor,
                ),
              )
            ],
          ),

          SizedBox(height: 10),
          CustomText(

            '${requestLeave.fromDate ?? ""} ${requestLeave.toDate ?? ""}',
            size: 16,
            weight: FontWeight.w700,
            color: ColorResource.black,
          ),
          
          CustomText(
            '$days Days • Applied on $appliedDate',
            size: 12,
            weight: FontWeight.w400,
            color: ColorResource.gray,
          ),

          SizedBox(height: 10),
         // if (requestLeave.status == 'APPROVED')
          if (requestLeave.status == 'Pending')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: ColorResource.searchBar
                      ),child: Icon(Icons.person),
                    ),
                    SizedBox(width: 5,),
                    CustomText(
                      'Approved by ${requestLeave.status}',
                      size: 12,
                      weight: FontWeight.w400,
                      color: ColorResource.gray,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Provider.of<LeaveProvider>(context, listen: false).getwithdrawnData( id: requestLeave.leaveRequestId.toString());
                    print(requestLeave.leaveRequestId.toString());
                  },
                  child: Container(
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
                  ),
                )
              ],
            ),

          if (requestLeave.status == 'Pending')
            CustomText(
              requestLeave.reason ?? '',
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
