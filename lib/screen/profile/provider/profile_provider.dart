
import 'package:flutter/material.dart';

import '../model/emergency_contact_model.dart';
import '../model/emergency_get_all_data_model.dart';
import '../model/get_profile_model.dart';
import '../repo/profile_repo.dart';

class ProfileProvider with ChangeNotifier {
   TextEditingController nameController = TextEditingController();
   TextEditingController relationController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController personEmailController = TextEditingController();

  final ProfileRepository _repo = ProfileRepository();

  bool loading = false;
  GetProfileModel? getProfileModel;

  Future<void> getProfileData({bool isRefresh = false}) async {
    loading = true;
    notifyListeners();
    try {
      getProfileModel = await _repo.getProfileApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }

   EmergencyGetAllDataModel? emergencyGetAllDataModel;

   Future<void> getemergencyGetAllData({bool isRefresh = false}) async {
     loading = true;
     notifyListeners();
     try {
       emergencyGetAllDataModel = await _repo.emergencyContactGetAllDataApi();
     } catch (e) {
       print("ReservedRides API ERROR: $e");
     }
     loading = false;
     notifyListeners();
   }


  EmergencyContactModel? _postEmergencyContactModel;
  EmergencyContactModel? get postEmergencyContactModel => _postEmergencyContactModel;

  String? _error;
  String? get error => _error;
  bool loading1 = false;

  Future<void> submitEmergencyContact(BuildContext context) async {
    final relation = relationController.text.trim();
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final email = personEmailController.text.trim();
    if (name.isEmpty) {
      _showMessage(context, "Contact name is required");
      return;
    }
    if (relation.isEmpty) {
      _showMessage(context, "Relation is required");
      return;
    }

    if (name.isEmpty) {
      _showMessage(context, "Contact name is required");
      return;
    }

    if (phone.isEmpty) {
      _showMessage(context, "Phone number is required");
      return;
    }

    if (phone.length < 8) {
      _showMessage(context, "Enter valid phone number");
      return;
    }

    if (email.isEmpty) {
      _showMessage(context, "Email is required");
      return;
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(email)) {
      _showMessage(context, "Enter valid email address");
      return;
    }
    loading1 = true;
    _error = null;
    notifyListeners();

    try {
      _postEmergencyContactModel = await _repo.emergencyContactApi(
        relation: relation,
        contact_name: name,
        personal_phone: phone,
        personal_email: email,
      );

      print("SUCCESS RESPONSE: $_postEmergencyContactModel");

      _showMessage(context, "Contact saved successfully");

      _clearFields();

    } catch (e) {
      _error = e.toString().replaceAll("Exception: ", "");
      print("ERROR: $_error");

      _showMessage(context, _error ?? "Something went wrong");
    } finally {
      loading1 = false;
      notifyListeners();
    }
  }


  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  void _clearFields() {
    relationController.clear();
    nameController.clear();
    phoneController.clear();
    personEmailController.clear();
  }


  @override
  void dispose() {
    nameController.dispose();
    relationController.dispose();
    phoneController.dispose();
    personEmailController.dispose();
    super.dispose();
  }

   Future<void> updateEmergencyContact(BuildContext context, String id) async {
     final relation = relationController.text.trim();
     final name = nameController.text.trim();
     final phone = phoneController.text.trim();
     final email = personEmailController.text.trim();

     if (relation.isEmpty) {
       _showMessage(context, "Relation is required");
       return;
     }

     if (name.isEmpty) {
       _showMessage(context, "Contact name is required");
       return;
     }

     if (phone.isEmpty) {
       _showMessage(context, "Phone number is required");
       return;
     }

     if (phone.length < 8) {
       _showMessage(context, "Enter valid phone number");
       return;
     }

     if (email.isEmpty) {
       _showMessage(context, "Email is required");
       return;
     }

     final emailRegex = RegExp(
       r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
     );

     if (!emailRegex.hasMatch(email)) {
       _showMessage(context, "Enter valid email address");
       return;
     }

     loading1 = true;
     _error = null;
     notifyListeners();

     try {

       _postEmergencyContactModel = await _repo.emergencyContactUpdateApi(
         id: id,
         relation: relation,
         contact_name: name,
         personal_phone: phone,
         personal_email: email,
       );

       print("UPDATE SUCCESS RESPONSE: $_postEmergencyContactModel");

       _showMessage(context, "Contact updated successfully");

       _clearFields();

     } catch (e) {
       _error = e.toString().replaceAll("Exception: ", "");
       print("ERROR: $_error");

       _showMessage(context, _error ?? "Something went wrong");
     } finally {
       loading1 = false;
       notifyListeners();
     }
   }

}