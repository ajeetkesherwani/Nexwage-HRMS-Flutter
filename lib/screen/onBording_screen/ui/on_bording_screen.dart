import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/navigator_method.dart';

import '../../auth/login_screen/ui/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> pages = [
    {
      "title": "Workforce\nManagement,\nSimplified.",
      "subtitle":
      "Manage attendance, payroll, and\nperformance from one powerful dashboard\nbuilt for modern teams.",
      "image": AppImages.onbording1,
    },
    {
      "title": "Automate\nWhat Matters.",
      "subtitle":
      "Streamline payroll, leave approvals, and\ncompliance without spreadsheets or\nmanual follow-ups.",
      "image": AppImages.onbording2,
    },
    {
      "title": "Empower Every\nEmployee",
      "subtitle":
      "Give your team transparency, self-service \naccess, and performance insights in one \nsecure platform.",
      "image": AppImages.onbording3,
    },
  ];

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      navPush(context: context, action: LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              ColorResource.onBording1,
              ColorResource.onBording2,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        pages.length,
                            (i) => Container(
                          margin: const EdgeInsets.only(right: 6),
                          width:
                          (MediaQuery.of(context).size.width - 48) / 3,
                          height: 6,
                          decoration: BoxDecoration(
                            color: i == currentIndex
                                ? ColorResource.darkCeruleanBlue
                                : ColorResource.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  navPush(context: context, action: LoginScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row( mainAxisAlignment: MainAxisAlignment.end, children: [ Container( padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1), decoration: BoxDecoration( border: Border.all( color: ColorResource.darkCeruleanBlue, width: 1, ), borderRadius: BorderRadius.circular(30), ), child: TextButton( style: TextButton.styleFrom( padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, ), onPressed: () { _controller.jumpToPage(pages.length - 1); }, child: const Text( 'Skip', style: TextStyle( color: ColorResource.darkCeruleanBlue, fontSize: 12, fontFamily: 'Sora', fontWeight: FontWeight.w300, height: 1.67, letterSpacing: -0.30, ), ), ), ), ], ),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() => currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final data = pages[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),

                          Text(
                            data["title"],
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            data["subtitle"],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),

                          const Spacer(),

                          Center(
                            child: Image.asset(
                              data["image"],
                              height: 250,
                            ),
                          ),

                          const Spacer(),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// 🔘 BUTTON SWITCH
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    currentIndex == pages.length - 1
                        ? GestureDetector(
                      onTap: nextPage,
                      child: Container(
                        width: 130,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              ColorResource.button1,
                              ColorResource.button2
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Get Started",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),


                              ],
                            ),
                            Positioned(
                              left: 86,
                              top: 3,
                              child:  Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 16),
                            ),
                            Positioned(
                              left: 80,
                              top: 3,
                              child:  Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 16),
                            )
                          ],
                        ),
                      ),
                    )
                        : GestureDetector(
                      onTap: nextPage,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF0052CC),
                              Color(0xFF002966)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [


                              ],
                            ),
                            Positioned(
                              left: 12,
                                top: 13,
                                child:  Icon(Icons.arrow_forward_ios,
                                    color: Colors.white, size: 16),
                            ),
                            Positioned(
                              left: 18,
                              top: 13,
                              child:  Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}