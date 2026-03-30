// import 'package:flutter/material.dart';
// import 'package:nexwage/util/color/app_colors.dart';
// import 'package:nexwage/widget/custom_text.dart';
// import 'package:provider/provider.dart';
// import '../model/holiday_model.dart';
// import '../provider/holiday_provider.dart';
//
// class UpComingScreen extends StatefulWidget {
//   const UpComingScreen({super.key});
//
//   @override
//   State<UpComingScreen> createState() => _UpComingScreenState();
// }
//
// class _UpComingScreenState extends State<UpComingScreen> {
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<HoliDayProvider>(context, listen: false).getProfileData();
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HoliDayProvider>(
//         builder: (context, holiDayProvider, child) {
//           return SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomText(
//                     "2024 CALENDAR",
//                     size: 12,
//                     weight: FontWeight.w700,
//                     color: ColorResource.grayText,
//                   ),
//                   SizedBox(height: 10,),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     padding: const EdgeInsets.all(16),
//                     itemCount: holiDayProvider.holidayModel?.data?.upcoming?.length,
//                     itemBuilder: (context, index) {
//                       final holiday = holiDayProvider.holidayModel?.data?.upcoming?[index];
//
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 60,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 color: ColorResource.orangeBackground,
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   CustomText(
//                                     '${holiday?.holidayName}',
//                                     size: 18,
//                                     weight: FontWeight.w700,
//                                     color: ColorResource.black,
//                                   ),
//                                   CustomText(
//                                     holiday!.startDate.toString(),
//                                    // getMonth(holiday.date.month),
//                                     size: 10,
//                                     weight: FontWeight.w700,
//                                     color: ColorResource.black,
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             const SizedBox(width: 12),
//
//                             // ✅ Card
//                             Expanded(
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
//                                 decoration: ShapeDecoration(
//                                   color: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     side: BorderSide(
//                                       width: 1,
//                                       color: const Color(0xFFF1F5F9),
//                                     ),
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   shadows: [
//                                     BoxShadow(
//                                       color: Color(0x0C000000),
//                                       blurRadius: 2,
//                                       offset: Offset(0, 1),
//                                       spreadRadius: 0,
//                                     )
//                                   ],
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         CustomText(
//                                          // getWeekday(holiday.date),
//                                           holiday!.startDate.toString(),
//                                           size: 12,
//                                           weight: FontWeight.w400,
//                                           color: ColorResource.grayText,
//                                         ),
//
//
//                                         const SizedBox(height: 4),
//                                         CustomText(
//                                           holiday?.holidayName ?? "",
//                                           size: 14,
//                                           weight: FontWeight.w700,
//                                           color: ColorResource.black,
//                                         ),
//                                       ],
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:provider/provider.dart';
import '../provider/holiday_provider.dart';
import 'package:intl/intl.dart';
class UpComingScreen extends StatefulWidget {
  const UpComingScreen({super.key});

  @override
  State<UpComingScreen> createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<HoliDayProvider>(context, listen: false)
          .getProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HoliDayProvider>(
      builder: (context, holiDayProvider, child) {
        final upcomingList =
            holiDayProvider.holidayModel?.data?.upcoming ?? [];
        final date = DateTime.tryParse(holiDayProvider.holidayModel?.data?.upcoming?[0].startDate ?? "");
        final year = date != null ? DateFormat('yyyy').format(date) : "";


        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "${year} CALENDAR",
                  size: 12,
                  weight: FontWeight.w700,
                  color: ColorResource.grayText,
                ),
                const SizedBox(height: 10),

                /// ✅ Handle empty state
                if (upcomingList.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("No Past Holidays"),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: upcomingList.length,
                    itemBuilder: (context, index) {
                      final holiday = upcomingList[index];
                      final date = DateTime.tryParse(holiday.startDate ?? "");
                      final dayNumber = date != null ? DateFormat('d').format(date) : "";
                      final dayName = date != null ? DateFormat('EEEE').format(date) : "";
                      final monthName = date != null ? DateFormat('MMM').format(date) : "";


                      final endDate = DateTime.tryParse(holiday.endDate ?? "");
                      final endDayNumber = endDate != null ? DateFormat('d').format(endDate) : "";
                      final endDayName = endDate != null ? DateFormat('EEEE').format(endDate) : "";
                      final endMonthName = endDate != null ? DateFormat('MMM').format(endDate) : "";

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            /// ✅ Left Box
                            Container(
                              width: 90,
                              height: 60,
                              decoration: BoxDecoration(
                                color: ColorResource.orangeBackground,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  /// 👉 Start Date
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        dayNumber,
                                        size: 18,
                                        weight: FontWeight.w700,
                                        color: ColorResource.black,
                                      ),
                                      CustomText(
                                        monthName,
                                        size: 10,
                                        weight: FontWeight.w700,
                                        color: ColorResource.black,
                                      ),
                                    ],
                                  ),

                                  /// 👉 Dash
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                    child: CustomText(
                                      "-",
                                      size: 16,
                                      weight: FontWeight.w700,
                                      color: ColorResource.black,
                                    ),
                                  ),

                                  /// 👉 End Date
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        endDayNumber,
                                        size: 18,
                                        weight: FontWeight.w700,
                                        color: ColorResource.black,
                                      ),
                                      CustomText(
                                        endMonthName,
                                        size: 10,
                                        weight: FontWeight.w700,
                                        color: ColorResource.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// ✅ Card
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      width: 1,
                                      color: Color(0xFFF1F5F9),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          dayName,
                                          size: 12,
                                          weight: FontWeight.w400,
                                          color: ColorResource.grayText,
                                        ),
                                        const SizedBox(height: 4),
                                        CustomText(
                                          holiday.holidayName ?? "",
                                          size: 14,
                                          weight: FontWeight.w700,
                                          color: ColorResource.black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}