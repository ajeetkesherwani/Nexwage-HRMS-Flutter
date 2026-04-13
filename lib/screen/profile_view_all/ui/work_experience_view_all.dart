import 'package:flutter/material.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:provider/provider.dart';

import '../../../util/color/app_colors.dart';
import '../../../widget/custom_text.dart';
import '../../profile/provider/profile_provider.dart';

class WorkExperienceViewAllScreen extends StatefulWidget {
  const WorkExperienceViewAllScreen({super.key});

  @override
  State<WorkExperienceViewAllScreen> createState() =>
      _WorkExperienceViewAllScreenState();
}

class _WorkExperienceViewAllScreenState
    extends State<WorkExperienceViewAllScreen> {
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      Provider.of<ProfileProvider>(context, listen: false).getAllexperence();
    });
  }

  Future<void> _handleRefresh() async {
    if (!mounted) return;

    setState(() {
      isRefreshing = true;
    });

    try {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getAllexperence(isRefresh: true);
    } catch (e) {
      debugPrint("Refresh Error: $e");
    }

    if (!mounted) return;

    setState(() {
      isRefreshing = false;
    });
  }

  /// Safe year formatter
  String formatYear(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      return date.split('-').first; // 2026-04-07 -> 2026
    } catch (e) {
      return date;
    }
  }

  Future<void> showExperienceDeleteDialog(
      BuildContext context,
      ProfileProvider profileProvider,
      String id,
      ) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Delete Icon
                Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    color: ColorResource.redBackground,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: ColorResource.red,
                    size: 36,
                  ),
                ),

                const SizedBox(height: 20),

                CustomText(
                  'Delete Work Experience?',
                  size: 22,
                  weight: FontWeight.w700,
                  color: ColorResource.black,
                ),

                const SizedBox(height: 12),

                CustomText(
                  'Are you sure you want to delete this work experience? Once deleted, it cannot be recovered.',
                  size: 14,
                  weight: FontWeight.w300,
                  color: ColorResource.gray,
                  align: TextAlign.center,
                ),

                const SizedBox(height: 28),

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(dialogContext);
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: CustomText(
                            'Cancel',
                            size: 16,
                            weight: FontWeight.w600,
                            color: ColorResource.black,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(dialogContext);

                          try {
                            await profileProvider.deleteExperience(
                              id: id,
                              isRefresh: true,
                            );
                          } catch (e) {
                            debugPrint("Delete Error: $e");
                          }

                          if (!mounted) return;

                          final isSuccess =
                              profileProvider.deleteExperienceModel?.status ==
                                  true;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor:
                              isSuccess ? Colors.green : Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              content: Text(
                                profileProvider
                                    .deleteExperienceModel?.message ??
                                    "Something went wrong",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorResource.red,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: CustomText(
                            'Delete',
                            size: 16,
                            weight: FontWeight.w700,
                            color: ColorResource.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final experienceList =
            profileProvider.experienceGetAllDataModel?.data ?? [];

        return SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: ColorResource.white,
            appBar: CommonAppBar(title: 'All Work Experience'),
            body: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: _handleRefresh,
                  color: ColorResource.button1,
                  child: experienceList.isEmpty
                      ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 100,
                    ),
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.work_outline_rounded,
                                size: 42,
                                color: ColorResource.gray,
                              ),
                            ),
                            const SizedBox(height: 18),
                            CustomText(
                              "No work experience available",
                              size: 18,
                              weight: FontWeight.w600,
                              color: ColorResource.black,
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              "Your added work experience will appear here.",
                              size: 14,
                              weight: FontWeight.w400,
                              color: ColorResource.gray,
                              align: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(15),
                    itemCount: experienceList.length,
                    itemBuilder: (context, index) {
                      final expData = experienceList[index];


                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFF1F5F9),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Leading Icon
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.work_outline_rounded,
                                color: ColorResource.gray,
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// Experience Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    expData.post ?? '',
                                    size: 14,
                                    weight: FontWeight.w700,
                                    color: ColorResource.black,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  CustomText(
                                    "${expData.companyName ?? ""} - ${expData.toYear?.split('-').last} - ${expData .fromYear?.split('-').last}",
                                    size: 12,
                                    weight: FontWeight.w400,
                                    color: ColorResource.gray,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 10),

                            /// Delete Button
                            GestureDetector(
                              onTap: () async {
                                await showExperienceDeleteDialog(
                                  context,
                                  profileProvider,
                                  expData.id.toString(),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF1F2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: ColorResource.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                if (isRefreshing)
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(
                      color: ColorResource.button1,
                      minHeight: 2,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}