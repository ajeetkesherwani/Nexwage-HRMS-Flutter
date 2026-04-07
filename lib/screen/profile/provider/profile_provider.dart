
import 'dart:io';

import 'package:flutter/material.dart';

import '../model/bankAccountPostModel.dart';
import '../model/chnagePasswordDataModel.dart';
import '../model/document_delete_model.dart';
import '../model/document_mater_model.dart';
import '../model/emergencyGetByIdModel.dart';
import '../model/emergency_contact_model.dart';
import '../model/emergency_get_all_data_model.dart';
import '../model/emergency_get_byId_update_model.dart';
import '../model/experienceGetAllDataModel.dart';
import '../model/getBankDataModel.dart';
import '../model/getDocumentDataModel.dart';
import '../model/get_profile_model.dart';
import '../model/qualificationGetDataModel.dart';
import '../repo/profile_repo.dart';

class ProfileProvider with ChangeNotifier {
   TextEditingController nameController = TextEditingController();
   TextEditingController relationController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController personEmailController = TextEditingController();

   TextEditingController bankController = TextEditingController();
   TextEditingController branchNameController = TextEditingController();
   TextEditingController accountHolderNameController = TextEditingController();
   TextEditingController accountNumberController = TextEditingController();
   TextEditingController accountTypeController = TextEditingController();
   TextEditingController ifscController = TextEditingController();


   TextEditingController currentControlleer = TextEditingController();
   TextEditingController newPasswordController = TextEditingController();
   TextEditingController conformPasswordController = TextEditingController();


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


   EmergencyGetByIdModel? emergencyGetByIdModel;



   Future<void> getemergencyGetByIdData({required String id}) async {
     loading = true;
     notifyListeners();

     try {
       emergencyGetByIdModel =
       await _repo.emergencyContactGetByIdDataApi(id: id);

       // ✅ SET DATA TO CONTROLLERS HERE
       final data = emergencyGetByIdModel?.data;

       if (data != null) {
         nameController.text = data.contactName ?? '';
         relationController.text = data.relation ?? '';
         phoneController.text = data.personalPhone ?? '';
         personEmailController.text = data.personalEmail ?? '';
       }

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
   EmergencyGetByIdUpdateModel? emergencyGetByIdUpdateModel;


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

       emergencyGetByIdUpdateModel = await _repo.emergencyContactUpdateApi(
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

   // Documnet Part ====================================
   DocumentMasterModel? documentMasterModel;

   Future<void> documnetMasterApiData({bool isRefresh = false}) async {
     loading = true;
     notifyListeners();
     try {
       documentMasterModel = await _repo.documnetMasterApi();
     } catch (e) {
       print("ReservedRides API ERROR: $e");
     }
     loading = false;
     notifyListeners();
   }

   //Document Post Model
   bool isLoading = false;
   Future<void> documentDataPost({
     required String document_title,
     required String document_type_id,
     required String expiry_date,
     File? document_file,
   }) async {


     try {
       isLoading = true;
       notifyListeners();

       final response = await _repo.documentPost(
         document_title: document_title,
         document_type_id: document_type_id,
         expiry_date: expiry_date,
         document_file: document_file,
       );

       if (response.status == true) {
         print(" Applied Successfully");
       } else {
         // errorMessage = response.message;
       }
     } catch (e) {
       // errorMessage = e.toString();
     } finally {
       isLoading = false;
       notifyListeners();
     }
   }

   // Get All Document Data
   GetDocumentDataModel? getDocumentDataModel;

   Future<void> getAllDocument({bool isRefresh = false}) async {
     loading = true;
     notifyListeners();
     try {
       getDocumentDataModel = await _repo.getAllDocument();
     } catch (e) {
       print("ReservedRides API ERROR: $e");
     }
     loading = false;
     notifyListeners();
   }

   //document Delete
   DocumentDeleteModel? documentDeleteModel;


   Future<void> deleteDocument({required String id, bool isRefresh = false}) async {
     loading = true;
     notifyListeners();

     try {
       final response = await _repo.documentDelete(id: id);

       if (response != null) {
         documentDeleteModel = response;
       } else {
         // fallback for APIs returning no content
         documentDeleteModel = DocumentDeleteModel(
           status: true,
           message: 'Document deleted successfully',
         );
       }

       if (isRefresh) {
         await refreshDocumentList();
       }
     } catch (e) {
       print("Delete Document API ERROR: $e");
       documentDeleteModel = DocumentDeleteModel(
         status: false,
         message: e.toString(),
       );
     } finally {
       loading = false;
       notifyListeners();
     }
   }


  Future<void> refreshDocumentList() async {

  }


  //Qualification Post Data

   Future<void> qualificationPostData({
     required String institution_name,
     required String education_level_id,
     required String from_date,
     required String to_date,
     File? attachment,
   }) async {
     try {
       isLoading = true;
       notifyListeners();

       final response = await _repo.qualificationPost(
         institution_name: institution_name,
         education_level_id: education_level_id,
         from_date: from_date,
         to_date: to_date,
         attachment: attachment,
       );

       if (response.status == true) {
         print(" Applied Successfully");
       } else {

       }
     } catch (e) {

     } finally {
       isLoading = false;
       notifyListeners();
     }
   }

   //Get All Qualification Data

   QualificationGetDataModel? qualificationGetDataModel;
   Future<void> getAllQualification({bool isRefresh = false}) async {
     loading = true;
     notifyListeners();
     try {
       qualificationGetDataModel = await _repo.getAllQualification();
     } catch (e) {
       print("ReservedRides API ERROR: $e");
     }
     loading = false;
     notifyListeners();
   }

   //experience

   Future<bool> experiencePostData({
     required String company_name,
     required String post,
     required String from_date,
     required String to_date,
     required String remark,
     File? attachment,
   }) async {
     try {
       isLoading = true;
       notifyListeners();

       final response = await _repo.experiencePost(
         company_name: company_name,
         post: post,
         from_date: from_date,
         to_date: to_date,
         remark: remark,
         attachment: attachment,
       );

       print("API Response Status: ${response.status}");
       print("API Response Message: ${response.message}");

       if (response.status == true) {
         return true;
       } else {
         return false;
       }
     } catch (e) {
       print("Experience Post Error: $e");
       return false;
     } finally {
       isLoading = false;
       notifyListeners();
     }
   }

   //Get All Experience Data

   ExperienceGetAllDataModel? experienceGetAllDataModel;
   Future<void> getAllexperence({bool isRefresh = false}) async {
     loading = true;
     notifyListeners();
     try {
       qualificationGetDataModel = await _repo.getAllQualification();
     } catch (e) {
       print("ReservedRides API ERROR: $e");
     }
     loading = false;
     notifyListeners();
   }

   //Post Bank Data Data

   BankAccountPostModel? bankAccountPostModel;

   Future<void> postBankAccountDetails(BuildContext context) async {
     loading1 = true;
     _error = null;
     notifyListeners();

     try {
       bankAccountPostModel = await _repo.bankAccountUpdateApi(
         account_title: accountHolderNameController .text.trim(),
         bank_branch: branchNameController .text.trim(),
         account_number: accountNumberController.text.trim(),
         bank_name: bankController.text.trim(),
         bank_code: ifscController.text.trim(),
         account_type: accountTypeController .text.trim(),
       );

       print("UPDATE SUCCESS RESPONSE: $bankAccountPostModel");

       _showMessage(context, "Bank account updated successfully");

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


   GetBankAccountModel? getBankAccountModel;

   Future<void> getBankData({bool isRefresh = false}) async {
     loading = true;
     notifyListeners();

     try {
       getBankAccountModel = await _repo.getBankData();

       final data = getBankAccountModel?.data;

       if (data != null) {
         accountHolderNameController.text = data.accountTitle ?? "";
         branchNameController.text = data.bankBranch ?? "";
         accountNumberController.text = data.accountNumber ?? "";
         bankController.text = data.bankName ?? "";
         ifscController.text = data.bankCode ?? "";
         //accountTypeController.text = data.accountType ?? "";
       }
     } catch (e) {
       print("Bank API ERROR: $e");
     }

     loading = false;
     notifyListeners();
   }

   //Change Password

   ChangePasswordDataModel? changePasswordDataModel;


   String? validateCurrentPassword(String? value) {
     if (value == null || value.trim().isEmpty) {
       return "Please enter current password";
     }
     return null;
   }

   String? validateNewPassword(String? value) {
     if (value == null || value.trim().isEmpty) {
       return "Please enter new password";
     }

     if (value.trim().length < 6) {
       return "Password must be at least 6 characters";
     }

     return null;
   }

   String? validateConfirmPassword(String? value) {
     if (value == null || value.trim().isEmpty) {
       return "Please confirm your password";
     }

     if (value.trim() != newPasswordController.text.trim()) {
       return "Confirm password does not match";
     }

     return null;
   }

   Future<void> changePassword(BuildContext context) async {
     loading1 = true;
     _error = null;
     notifyListeners();

     try {
       changePasswordDataModel = await _repo.changePassword(
         current_password: currentControlleer.text.trim(),
         new_password: newPasswordController.text.trim(),
       );

       print("UPDATE SUCCESS RESPONSE: $changePasswordDataModel");

       _showMessage(context, "Password updated successfully");

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