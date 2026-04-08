import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../../profile_view_all/model/delete_emergencymodel.dart';
import '../model/bankAccountPostModel.dart';
import '../model/chnagePasswordDataModel.dart';
import '../model/document_delete_model.dart';
import '../model/document_mater_model.dart';
import '../model/document_post_model.dart';
import '../model/emergencyGetByIdModel.dart';
import '../model/emergency_contact_model.dart';
import '../model/emergency_get_all_data_model.dart';
import '../model/emergency_get_byId_update_model.dart';
import '../model/experienceGetAllDataModel.dart';
import '../model/experiencePostModel.dart';
import '../model/getBankDataModel.dart';
import '../model/getDocumentDataModel.dart';
import '../model/get_profile_model.dart';
import '../model/postProfileDataModel.dart';
import '../model/postSocialModel.dart';
import '../model/qualificationGetDataModel.dart';
import '../model/qualification_post_model.dart';



class ProfileRepository {
  final _apiService = NetworkApiServices();

  Future<GetProfileModel> getProfileApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.getProfile);
      print('response: $response');
      if (response != null) {
        return GetProfileModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }


  Future<EmergencyGetAllDataModel> emergencyContactGetAllDataApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.emergencyContactPost);
      print('response: $response');
      if (response != null) {
        return EmergencyGetAllDataModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }

  Future<EmergencyGetByIdModel> emergencyContactGetByIdDataApi({required String id}) async {
    try {
      final response = await _apiService.getApiWithToken("${AppUrl.emergencyContactPost}/${id}");
      print('response: $response');
      if (response != null) {
        return EmergencyGetByIdModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }

  Future<EmergencyContactModel> emergencyContactApi({
    required String relation,
    required String contact_name,
    required String personal_phone,
    required String personal_email,

  }) async {
    try {
      final Map<String, dynamic> body = {
        "relation": relation,
        "contact_name": contact_name,
        "personal_phone": personal_phone,
        "personal_email": personal_email,
      };
      final response = await _apiService.postApiWithToken(
          body,
          "${AppUrl.emergencyContactPost}"
      );

      print('response: $response');

      if (response != null) {
        return EmergencyContactModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error sending data: $e');
      rethrow;
    }
  }

  Future<EmergencyGetByIdUpdateModel> emergencyContactUpdateApi({
    required String id,
    required String relation,
    required String contact_name,
    required String personal_phone,
    required String personal_email,

  }) async {
    try {
      final Map<String, dynamic> body = {
        "relation": relation,
        "contact_name": contact_name,
        "personal_phone": personal_phone,
        "personal_email": personal_email,
      };
      final response = await _apiService.postApiWithToken(
          body,
          "${AppUrl.emergencyContactPost}/$id/update",
      );

      print('response: $response');

      if (response != null) {
        return EmergencyGetByIdUpdateModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error sending data: $e');
      rethrow;
    }
  }


  // Documnet Part =====================================

  Future<DocumentMasterModel> documnetMasterApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.masterData);
      print('response: $response');
      if (response != null) {
        return DocumentMasterModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }


//Document Post Api

  Future<DocumentPostModel> documentPost({
    required String document_title,
    required String document_type_id,
    required String expiry_date,
    File? document_file,
    String? oldProfileImage,
  }) async {
    final url = AppUrl.document;

    try {
      final fields = {
        "document_title": document_title,
        "document_type_id": document_type_id,
        "expiry_date": expiry_date,
      };

      if (document_file == null && oldProfileImage != null) {
        fields["attachment"] = oldProfileImage;
      }
      final files = <String, File>{};
      if (document_file != null) {
        files["attachment"] = document_file;
      }
      if (kDebugMode) {
        log("📤 Fields => $fields");
        log("🖼 Files => ${files.keys}");
      }

      final response =
      await _apiService.postMultipartApiWithToken(
        url: url,
        fields: fields,
        files: files,
      );
      return DocumentPostModel.fromJson(response);
    } catch (e) {
      log(" Apply Leave API Error => $e");
      rethrow;
    }
  }

  // Get All Document Data
  Future<GetDocumentDataModel> getAllDocument() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.document);
      print('response: $response');
      if (response != null) {
        return GetDocumentDataModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }
// Document Delete


  Future<DocumentDeleteModel> documentDelete({required String id}) async {
    try {
      final response = await _apiService.deleteApiWithToken("${AppUrl.document}/$id");

      if (response == null || response.isEmpty) {
        return DocumentDeleteModel(status: true, message: 'Document deleted successfully');
      }

      return DocumentDeleteModel.fromJson(response);
    } catch (e) {
      print('Error deleting document: $e');
      rethrow;
    }
  }
//  Qualification Post Data

  Future<QualificationPostModel> qualificationPost({
    required String institution_name,
    required String education_level_id,
    required String from_date,
    required String to_date,
    File? attachment,
    String? oldProfileImage,
  }) async {
    final url = AppUrl.qualifications;

    try {
      final fields = {
        "institution_name": institution_name,
        "education_level_id": education_level_id,
        "from_date": from_date,
        "to_date": to_date,
      };

      if (attachment == null && oldProfileImage != null) {
        fields["attachment"] = oldProfileImage;
      }
      final files = <String, File>{};
      if (attachment != null) {
        files["attachment"] = attachment;
      }
      if (kDebugMode) {
        log(" Fields => $fields");
        log(" Files => ${files.keys}");
      }

      final response =
      await _apiService.postMultipartApiWithToken(
        url: url,
        fields: fields,
        files: files,
      );
      return QualificationPostModel.fromJson(response);
    } catch (e) {
      log(" Apply Leave API Error => $e");
      rethrow;
    }
  }

  //Get All Qualification

  Future<QualificationGetDataModel> getAllQualification() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.qualifications);
      print('response: $response');
      if (response != null) {
        return QualificationGetDataModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }
  //experience


  Future<ExperiencePostModel> experiencePost({
    required String company_name,
    required String post,
    required String from_date,
    required String to_date,
    required String remark,
    File? attachment,
    String? oldProfileImage,
  }) async {
    final url = AppUrl.experiences;

    try {
      final fields = {
        "company_name": company_name,
        "post": post,
        "from_date": from_date,
        "to_date": to_date,
        "remark": remark,
      };

      if (attachment == null && oldProfileImage != null) {
        fields["attachment"] = oldProfileImage;
      }
      final files = <String, File>{};
      if (attachment != null) {
        files["attachment"] = attachment;
      }
      if (kDebugMode) {
        log(" Fields => $fields");
        log(" Files => ${files.keys}");
      }

      final response =
      await _apiService.postMultipartApiWithToken(
        url: url,
        fields: fields,
        files: files,
      );
      return ExperiencePostModel.fromJson(response);
    } catch (e) {
      log(" experience API Error => $e");
      rethrow;
    }
  }

  //experice get All Data

  Future<ExperienceGetAllDataModel> getAllExperience() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.experiences);
      print('response: $response');
      if (response != null) {
        return ExperienceGetAllDataModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }
//Bank Account Post Data

  Future<BankAccountPostModel> bankAccountUpdateApi({
    required String account_title,
    required String bank_branch,
    required String account_number,
    required String bank_name,
    required String bank_code,
    required String account_type,

  }) async {
    try {
      final Map<String, dynamic> body = {
        "account_title": account_title,
        "bank_branch": bank_branch,
        "account_number": account_number,
        "bank_name": bank_name,
        "bank_code": bank_code,
        "account_type": account_type,
      };
      final response = await _apiService.postApiWithToken(
        body,
        "${AppUrl.bankDetails}",
      );

      print('response: $response');

      if (response != null) {
        return BankAccountPostModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error sending data: $e');
      rethrow;
    }
  }
//get Bank Details
  Future<GetBankAccountModel> getBankData() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.bankDetails);
      print('response: $response');
      if (response != null) {
        return GetBankAccountModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }

  //Change Password

  Future<ChangePasswordDataModel> changePassword({
    required String current_password,
    required String new_password,

  }) async {
    try {
      final Map<String, dynamic> body = {
        "current_password": current_password,
        "new_password": new_password,
      };
      final response = await _apiService.postApiWithToken(
        body,
        "${AppUrl.changePassword}",
      );

      print('response: $response');

      if (response != null) {
        return ChangePasswordDataModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error sending data: $e');
      rethrow;
    }
  }


  //Post Profile Details


  Future<PostProfileDataModel> postProfileDetails({
    required String first_name,
    required String last_name,
    File? profile_photo,
    String? oldProfileImage,
  }) async {
    final url = AppUrl.getProfile;

    try {
      final fields = {
        "first_name": first_name,
        "last_name": last_name,
      };

      if (profile_photo == null && oldProfileImage != null) {
        fields["attachment"] = oldProfileImage;
      }
      final files = <String, File>{};
      if (profile_photo != null) {
        files["attachment"] = profile_photo;
      }
      if (kDebugMode) {
        log(" Fields => $fields");
        log(" Files => ${files.keys}");
      }

      final response =
      await _apiService.postMultipartApiWithToken(
        url: url,
        fields: fields,
        files: files,
      );
      return PostProfileDataModel.fromJson(response);
    } catch (e) {
      log(" experience API Error => $e");
      rethrow;
    }
  }

  //Post Basic Details

  Future<PostProfileDataModel> postBasicDetails({
    required String first_name,
    required String last_name,
    required String gender,
    required String date_of_birth,
    required String contact_no,
    required String marital_status,
    required String blood_grp,
    required String email,
    required String address,

  }) async {
    try {
      final Map<String, dynamic> body = {
        "first_name": first_name,
        "last_name": last_name,
        "gender": gender,
        "date_of_birth": date_of_birth,
        "contact_no": contact_no,
        "marital_status": marital_status,
        "blood_grp": blood_grp,
        "email": email,
        "address": address,

      };
      final response = await _apiService.postApiWithToken(
        body,
        "${AppUrl.getProfile}",
      );

      print('response: $response');

      if (response != null) {
        return PostProfileDataModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error sending data: $e');
      rethrow;
    }
  }

  //Edit Social
  Future<PostSocialModel> postSocial({
    required String fb_id,
    required String twitter_id,
    required String linkedIn_id,
    required String whatsapp_id,
    required String skype_id,

  }) async {
    try {
      final Map<String, dynamic> body = {
        "fb_id": fb_id,
        "twitter_id": twitter_id,
        "linkedIn_id": linkedIn_id,
        "whatsapp_id": whatsapp_id,
        "skype_id": skype_id,

      };
      final response = await _apiService.postApiWithToken(
        body,
        "${AppUrl.getProfile}",
      );

      print('response: $response');

      if (response != null) {
        return PostSocialModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error sending data: $e');
      rethrow;
    }
  }
//Delete Emergency Contact

  Future<DeleteEmergencyContactModel> deleteEmergencyContact({required String id}) async {
    try {
      final response = await _apiService.deleteApiWithToken("${AppUrl.emergencyContactPost}/$id");

      if (response == null || response.isEmpty) {
        return DeleteEmergencyContactModel(status: true, message: 'Document deleted successfully');
      }

      return DeleteEmergencyContactModel.fromJson(response);
    } catch (e) {
      print('Error deleting document: $e');
      rethrow;
    }
  }

}