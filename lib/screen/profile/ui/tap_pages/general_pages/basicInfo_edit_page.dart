import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
import 'package:provider/provider.dart';
import '../../../../../util/color/app_colors.dart';
import '../../../provider/profile_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';


class BasicInfoEditPage extends StatefulWidget {
  const BasicInfoEditPage({super.key,});

  @override
  State<BasicInfoEditPage> createState() => _BasicInfoEditPageState();
}

class _BasicInfoEditPageState extends State<BasicInfoEditPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
       Provider.of<ProfileProvider>(context, listen: false).getProfileData();
       final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
       final profile = profileProvider.getProfileModel?.data;
       if (profile != null) {
         firstNameController.text = profile.firstName ?? '';
         lastNameController.text = profile.lastName ?? '';
         genderController.text = profile.gender ?? '';
         dobController.text = profile.dateOfBirth ?? '';
         phoneController.text = profile.phone ?? '';
         maritalController.text = profile.maritalStatus ?? '';
         bloodController.text = profile.bloodGrp ?? '';
         emailController.text = profile.email ?? '';
         addressController.text = profile.address ?? '';
       }
    });
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
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
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
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
                      label("First Name"),
                      CommonTextFormField(
                        hintText: 'First Name',
                        controller: firstNameController,
                      ),
                      label("Last Name"),
                      CommonTextFormField(
                        hintText: 'Last Name',
                        controller: lastNameController,
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
                        prefixIcon: Icons.calendar_month,
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
                        isLoading: profileProvider.isLoading,
                        onPressed: () async{
                         bool success =await profileProvider.postBasicDetails(
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              gender: genderController.text.trim(),
                              dateOfBirth: dobController.text.trim(),
                              contactNo: phoneController.text.trim(),
                              maritalStatus: maritalController.text.trim(),
                              bloodGrp: bloodController.text.trim(),
                              email: emailController.text.trim(),
                              address: addressController.text.trim(),
                          );

                          if (success) {
                            Fluttertoast.showToast(
                              msg: "Profile updated successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Failed to update profile",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
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