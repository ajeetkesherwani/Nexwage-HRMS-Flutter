import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/custom_text.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  int selectedIndex = 0;

  final List<String> filters = [
    "All",
    "Open",
    "In Progress",
    "Resolved"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CommonAppBar(title: 'Tickets'),
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
                      id: "#TIC-8831",
                      title: "Incorrect TDS deduction",
                      category: "Payroll",
                      status: "In Progress",
                      date: "24 Oct, 2023",
                      priority: "HIGH",
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
    required String id,
    required String title,
    required String category,
    required String status,
    required String date,
    required String priority,
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

    return Container(
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
              CustomText(
                id,
                size: 12,
                weight: FontWeight.w700,
                color: ColorResource.gray,
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: priorityBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  '$priority PRIORITY',
                  size: 10,
                  weight: FontWeight.w700,
                  color: priorityText,
                ),
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

          /// Category
          CustomText(
            'Category: $category',
            size: 14,
            weight: FontWeight.w400,
            color: ColorResource.gray,
          ),
          const SizedBox(height: 10),

          Divider(),

          const SizedBox(height: 8),

          /// Bottom Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: statusColor,
                  ),
                  const SizedBox(width: 6),
                  CustomText(
                    status,
                    size: 12,
                    weight: FontWeight.w500,
                    color: ColorResource.gray
                  )
                ],
              ),
              CustomText(
                  date,
                size: 13,
                weight: FontWeight.w400,
                color: ColorResource.grayText,
              )
            ],
          )
        ],
      ),
    );
  }
}