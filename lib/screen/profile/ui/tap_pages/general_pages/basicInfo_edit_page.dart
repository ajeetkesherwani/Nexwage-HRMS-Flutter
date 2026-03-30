import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
import '../../../../../util/color/app_colors.dart';

class BasicInfoEditPage extends StatefulWidget {
  final Map<String, String> data;
  const BasicInfoEditPage({super.key, required this.data});

  @override
  State<BasicInfoEditPage> createState() => _BasicInfoEditPageState();
}

class _BasicInfoEditPageState extends State<BasicInfoEditPage> {
  @override
  void initState() {
    super.initState();

    nameController.text = widget.data["name"] ?? "";
    dobController.text = widget.data["dob"] ?? "";
    maritalController.text = widget.data["marital"] ?? "";
    genderController.text = widget.data["gender"] ?? "";
    phoneController.text = widget.data["phone"] ?? "";
    bloodController.text = widget.data["blood"] ?? "";
    emailController.text = widget.data["email"] ?? "";
    addressController.text = widget.data["address"] ?? "";
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController maritalController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  List<String> genderList = ["Male", "Female", "Other"];
  List<String> maritalList = ["Single", "Married", "Divorced"];

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  void _selectGender() async {
    String? selected = await showModalBottomSheet<String>(
      context: context,
      builder: (_) {
        return ListView(
          children: genderList.map((e) {
            return ListTile(
              title: Text(e),
              onTap: () {
                Navigator.pop(context, e);
              },
            );
          }).toList(),
        );
      },
    );

    if (selected != null) {
      setState(() {
        genderController.text = selected;
      });
    }
  }

  void _selectMarital() async {
    String? selected = await showModalBottomSheet<String>(
      context: context,
      builder: (_) {
        return ListView(
          children: maritalList.map((e) {
            return ListTile(
              title: Text(e),
              onTap: () {
                Navigator.pop(context, e);
              },
            );
          }).toList(),
        );
      },
    );

    if (selected != null) {
      setState(() {
        maritalController.text = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CommonAppBar(title: 'Basic Info Edit'),
        backgroundColor: ColorResource.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                label("Full Name"),
                CommonTextFormField(
                  hintText: 'Full Name',
                  controller: nameController,
                ),


                label("Gender"),
                CommonTextFormField(
                  hintText: 'Select Gender',
                  controller: genderController,
                  readOnly: true,
                  onTap: _selectGender,
                  suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                ),


                label("DOB"),
                CommonTextFormField(
                  hintText: 'Select DOB',
                  controller: dobController,
                  readOnly: true,
                  onTap: _selectDate,
                  suffixIcon: Icon(Icons.calendar_month),
                ),


                label("Phone"),
                CommonTextFormField(
                  hintText: 'Phone',
                  controller: phoneController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                ),


                label("Marital Status"),
                CommonTextFormField(
                  hintText: 'Select Status',
                  controller: maritalController,
                  readOnly: true,
                  onTap: _selectMarital,
                  suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                ),


                label("Blood Group"),
                CommonTextFormField(
                  hintText: 'Blood Group',
                  controller: bloodController,
                ),


                label("Email"),
                CommonTextFormField(
                  hintText: 'Email',
                  controller: emailController,
                ),

                label("Address"),
                CommonTextFormField(
                  hintText: 'Address',
                  controller: addressController,
                ),

                SizedBox(height: 20),

                CommonAppButton(
                  text: 'Save',
                  onPressed: () {
                    Map<String, String> updatedData = {
                      "name": nameController.text,
                      "dob": dobController.text,
                      "marital": maritalController.text,
                      "gender": genderController.text,
                      "phone": phoneController.text,
                      "blood": bloodController.text,
                      "email": emailController.text,
                      "address": addressController.text,
                    };

                    Navigator.pop(context, updatedData);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Reusable Label
  Widget label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 10),
      child: CustomText(
        text,
        size: 12,
        weight: FontWeight.w400,
        color: ColorResource.black,
      ),
    );
  }
}