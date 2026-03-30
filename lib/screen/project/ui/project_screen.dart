import 'package:flutter/material.dart';
import 'package:nexwage/screen/project/ui/project_byId_screen.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:nexwage/widget/navigator_method.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  int selectedIndex = 0;

  final List<String> filters = [
    "All",
    "High Priority",
    "In Progress",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CommonAppBar(title: 'Projects'),
        backgroundColor: ColorResource.white,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: ColorResource.searchBar,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search by ID or subject",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Container(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 5),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorResource.button1
                              : ColorResource.searchBar,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child:
                            CustomText(
                              filters[index],
                              size: 14,
                              weight: FontWeight.w500,
                              color: isSelected
                                  ?ColorResource.white
                                  :ColorResource.grayText,
                            )
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ticketCard(
                      title: "Employee Portal Redesign",
                      status: "In Progress",
                      date: "24 Oct, 2023",
                      priority: "HIGH",
                        companyName: 'TechCorp Inc.',
                        progress: 0.65,
                        progressValue: 65,
                        onTap: (){
                          navPush(context: context, action:
                          ProjectByidScreen(
                              title: 'Employee Portal Redesign',
                            companyName: "TechCorp Inc.",
                          ));
                        },
                        subtitle:"Complete overhaul of the internal HR portal with focus on mobile accessibility and payroll…"
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🎫 Ticket Card Widget
  Widget ticketCard({
    required String title,
    required String subtitle,
    required String status,
    required String companyName,
    required String date,
    required String priority,
    required double progress,
    required int progressValue,
    required VoidCallback onTap,
  }) {
    Color statusColor = status == "Resolved"
        ? Colors.green
        : status == "Open"
        ? Colors.blue
        : Colors.orange;

    Color priorityBg = priority == "HIGH"
        ? Colors.red.shade100
        : priority == "MEDIUM"
        ? Colors.blue.shade100
        : Colors.grey.shade300;

    Color priorityText = priority == "HIGH"
        ? Colors.red
        : priority == "MEDIUM"
        ? Colors.blue
        : Colors.black54;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ColorResource.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xffE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: priorityBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: priorityText,
                      ),
                      SizedBox(width: 6,),
                      CustomText(
                        '$priority PRIORITY',
                        size: 12,
                        weight: FontWeight.w400,
                        color: priorityText,
                      ),
                    ],
                  ),
                ),
                CustomText(
                  "End: ${date}",
                  size: 13,
                  weight: FontWeight.w400,
                  color: ColorResource.grayText,
                )
              ],
            ),

            const SizedBox(height: 8),

            CustomText(
                title,
                size: 16,
                weight: FontWeight.w700,
                color: ColorResource.black
            ),

            const SizedBox(height: 5),
            CustomText(
              subtitle,
              size: 12,
              weight: FontWeight.w400,
              color: ColorResource.grayText,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Progress',
                  size: 12,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                ),
                CustomText(
                  '${progressValue}%',
                  size: 12,
                  weight: FontWeight.w400,
                  color: ColorResource.button1,
                ),
              ],
            ),
            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorResource.button1
                ),
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 40,
                      child: Stack(
                        children: [
                          buildAvatar("https://i.pravatar.cc/150?img=1", 0),
                          buildAvatar("https://i.pravatar.cc/150?img=2", 20),
                          buildAvatar("https://i.pravatar.cc/150?img=3", 40),
                          Positioned(
                            left: 60,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  "+2",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                     'CLIENT',
                      size: 10,
                      weight: FontWeight.w700,
                      color: ColorResource.grayText,
                    ),
                    CustomText(
                      companyName,
                      size: 12,
                      weight: FontWeight.w600,
                      color: ColorResource.gray,
                    )
                  ],
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
  Widget buildAvatar(String imageUrl, double left) {
    return Positioned(
      left: left,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}