import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';
class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.only(bottom: 10),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: toDoCard(
            title: 'Review Quarter Performance',
            status: 'HIGH',
            date: 'Due 24 Oct, 2023',
            name: 'Daman Singh',
            assigned: 'MANAGER ASSIGNED',
          ),
        );
      },
    );
  }
  Widget toDoCard({
    required String title,
    required String status,
    required String date,
    required String name,
    required String assigned,
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
      ),child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    color: const Color(0xFFCBD5E1),
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            SizedBox(width: 10,),
            CustomText(
              title,
              size: 14,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7,vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorResource.redBackground,
              ),child: CustomText(
              status,
              size: 10,
              weight: FontWeight.w700,
              color: ColorResource.red,
            ),
            )
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconTitle(
                image: AppImages.caledar,
                title: date,
            ),
            iconTitle(
              image: AppImages.personImage,
              title: name,
            ),
          ],
        ),
        SizedBox(height: 10,),
        Divider(
          color: ColorResource.searchBar,
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              assigned,
              size: 10,
              weight: FontWeight.w400,
              color: ColorResource.grayText,
            ),
            SizedBox(
              width: 120,
              height: 40,
              child: Stack(
                children: [
                  buildAvatar("https://i.pravatar.cc/150?img=1", 0),
                  buildAvatar("https://i.pravatar.cc/150?img=2", 20),
                  buildAvatar("https://i.pravatar.cc/150?img=3", 40),
                ],
              ),
            ),
          ],
        )
      ],
    ),
    );
  }
  Widget iconTitle({
    required String image,
    required String title,
}){
    return Row(
      children: [
        CustomImageView(
            imagePath: image,
          height:12,
          width: 12,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 5,),
        CustomText(
          title,
          size: 10,
          weight: FontWeight.w400,
          color: ColorResource.gray,
        )
      ],
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
