import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nexwage/screen/profile/ui/profile_image_edit.dart';
import 'package:nexwage/screen/profile/ui/profile_tab.dart';
import 'package:nexwage/screen/profile/ui/tap_pages/core_hr_pages/core_hr_screen.dart';
import 'package:nexwage/screen/profile/ui/tap_pages/general_pages/general_screen.dart';
import 'package:nexwage/screen/profile/ui/tap_pages/salary_pages/salary_screen.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:nexwage/widget/navigator_method.dart';
import 'package:provider/provider.dart';
import '../../../util/color/app_colors.dart';
import '../../../widget/commonAppBar.dart';
import '../../setting_screen/ui/setting_screen.dart';
import '../provider/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).getProfileData();
    });
  }
  String? name;
  String? title;
  File? profileImage;

  Future<void> openEditProfile() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileImageEdit()),);

    if (result != null) {
      setState(() {
        name = result['name'];
        title = result['title'];

        if (result['image'] != null) {
          profileImage = File(result['image']);
        }
      });
    }
  }
  int selectedTab = 0;
  bool isRefreshing = false;
  final List<String> tabs = ["General", "Salary", "Core HR"];
  Future<void> _handleRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    await Provider.of<ProfileProvider>(context, listen: false)
        .getProfileData(isRefresh: true);

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
              appBar: CommonAppBar(
                title: 'Profile',
                actionImage: AppImages.settingImage,
                onActionTap: (){
                  navPush(context: context, action: SettingScreen());
                },
              ),
              backgroundColor: ColorResource.white,
              body:


              Stack(
                children: [



                  RefreshIndicator(
                    onRefresh: _handleRefresh,

                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 128,
                                    height: 128,
                                    decoration: ShapeDecoration(
                                      image: profileImage != null
                                          ? DecorationImage(
                                        image: FileImage(profileImage!),
                                        fit: BoxFit.cover,
                                      )
                                          : null,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 4,
                                          color: const Color(0x191D4FD7),
                                        ),
                                        borderRadius: BorderRadius.circular(9999),
                                      ),
                                    ),

                                    child: profileImage == null
                                        ? Icon(Icons.person, size: 60, color: Colors.grey)
                                        : null,
                                  ),

                                  Positioned(
                                    bottom: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: openEditProfile,
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: ColorResource.button1,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomText(
                              profileProvider.getProfileModel?.data?.fullName ?? "",
                            //  name ?? "Your Name",
                              size: 18,
                              weight: FontWeight.w700,
                              color: ColorResource.black,
                            ),
                            CustomText(
                              "SENIOR  MANAGER",
                              //title ?? "Your Title",
                              size: 14,
                              weight: FontWeight.w600,
                              color: ColorResource.button1,
                            ),
                            SizedBox(height: 10,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: ColorResource.searchBar,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomImageView(
                                    imagePath: AppImages.empImage,
                                    height: 13,
                                    width: 13,
                                  ),
                                  SizedBox(width: 5),
                                  CustomText(
                                    profileProvider.getProfileModel?.data?.staffId ?? "",
                                    size: 12,
                                    weight: FontWeight.w500,
                                    color: ColorResource.gray,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: ColorResource.white,
                                border: const Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: List.generate(
                                  tabs.length,
                                      (index) => Expanded(
                                    child: ProfileTabItem(
                                      title: tabs[index],
                                      isSelected: selectedTab == index,
                                      onTap: () {
                                        setState(() {
                                          selectedTab = index;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),


                            const SizedBox(height: 10),

                            selectedTab == 0
                                ? const GeneralScreen()
                                : selectedTab == 1
                                ? const SalaryScreen()
                                : const CoreHrScreen(),

                          ],
                        ),
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
          );
        }

    );
  }
}