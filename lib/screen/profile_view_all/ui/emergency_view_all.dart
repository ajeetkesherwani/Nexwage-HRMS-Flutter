import 'package:flutter/material.dart';
import 'package:nexwage/screen/profile/provider/profile_provider.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:provider/provider.dart';

import '../../../util/color/app_colors.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/navigator_method.dart';
import '../../profile/model/emergency_get_all_data_model.dart';
import '../../profile/ui/tap_pages/general_pages/edit_pages/emergency_edit_screen.dart';
class EmergencyViewAllScreen extends StatefulWidget {
  const EmergencyViewAllScreen({super.key});

  @override
  State<EmergencyViewAllScreen> createState() => _EmergencyViewAllScreenState();
}

class _EmergencyViewAllScreenState extends State<EmergencyViewAllScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {

      Provider.of<ProfileProvider>(context, listen: false).getemergencyGetAllData();

    });
  }

  Future<void> showDeleteEmergencyContactDialog(
      BuildContext context,
      ProfileProvider profileProvider,
      String id,
      ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
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
                // Delete Icon
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
                  'Delete Contact?',
                  size: 22,
                  weight: FontWeight.w700,
                  color: ColorResource.black,
                ),

                const SizedBox(height: 12),

                CustomText(
                  'Are you sure you want to delete this emergency contact? This action cannot be undone.',
                  size: 14,
                  weight:FontWeight.w300,
                  color: ColorResource.gray,
                ),

                const SizedBox(height: 28),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          height: 45,
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
                          )
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);

                          await profileProvider.deleteEmergencyContact(
                            id: id,
                            isRefresh: true,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor:
                              profileProvider.deleteEmergencyContactModel?.status == true
                                  ? Colors.green
                                  : Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              content: Text(
                                profileProvider.deleteEmergencyContactModel?.message ??
                                    "Something went wrong",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF5A5F), Color(0xFFFF2D55)],
                            ),
                            borderRadius: BorderRadius.circular(14),

                          ),
                          child: CustomText(
                            'Delete',
                            size: 16,
                            weight: FontWeight.w700,
                            color: ColorResource.white,
                          )
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
  bool isRefreshing = false;

  Future<void> _handleRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    await Provider.of<ProfileProvider>(context, listen: false)
        .getemergencyGetAllData(isRefresh: true);

    setState(() {
      isRefreshing = false;
    });
  }
  @override
    Widget build(BuildContext context) {
      return Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            return  SafeArea(
              top: false,
                child: Scaffold(
                  appBar: CommonAppBar(title: 'All Emergency Contact'),
                  backgroundColor: ColorResource.white,
                  body: Padding(
                      padding: EdgeInsets.all(15),
                    child: Stack(
                      children: [
                        RefreshIndicator(
                          onRefresh: _handleRefresh,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                (profileProvider.emergencyGetAllDataModel?.data?.isNotEmpty ?? false)
                                    ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                   itemCount: profileProvider.emergencyGetAllDataModel?.data?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final item = profileProvider.emergencyGetAllDataModel?.data?[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: emergencyCard(item!, index),
                                    );
                                  },
                                )
                                    : CustomText('No contact added'),
                              ],
                            ),
                          ),
                        ),
                        if (isRefreshing)
                          const Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(child:  LinearProgressIndicator(
                              color: ColorResource.button1,
                              minHeight: 2,
                            )),
                          ),
                      ],
                    ),
                  ),
                )
            );
          }
      );
    }
  Widget emergencyCard(EmergencyContactData data, int index) {
    return
    Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return  Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE2E8F0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: ColorResource.searchBar,
                  ),
                  child: Icon(Icons.person_2_outlined, color: ColorResource.gray),
                ),

                SizedBox(width: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      data.contactName ?? "",
                      size: 14,
                      weight: FontWeight.w600,
                      color: ColorResource.black,
                    ),
                    CustomText(
                      '${data.relation ?? ''} • ${data.personalPhone ?? ''}',
                      size: 12,
                      weight: FontWeight.w400,
                      color: ColorResource.gray,
                    ),
                  ],
                ),

                Spacer(),

                GestureDetector(
                    onTap: () async {
                      navPush(context: context, action: EmergencyContactEditScreen(
                        id: data.id.toString(),
                      ));


                    },
                    child: Icon(Icons.edit, color: ColorResource.button1)
                ),
                // GestureDetector(
                //     onTap: () async {
                //       await profileProvider.deleteEmergencyContact(id: data.id.toString());
                //
                //     },
                //     child: Icon(Icons.delete, color: ColorResource.red)
                // )
                GestureDetector(
                  onTap: () async {
                    await showDeleteEmergencyContactDialog(
                      context,
                      profileProvider,
                      data.id.toString(),
                    );
                  },
                  child: Icon(
                    Icons.delete,
                    color: ColorResource.red,
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}
