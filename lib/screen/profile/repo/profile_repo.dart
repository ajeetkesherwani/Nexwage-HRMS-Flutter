import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/document_delete_model.dart';
import '../model/document_mater_model.dart';
import '../model/document_post_model.dart';
import '../model/emergencyGetByIdModel.dart';
import '../model/emergency_contact_model.dart';
import '../model/emergency_get_all_data_model.dart';
import '../model/emergency_get_byId_update_model.dart';
import '../model/getDocumentDataModel.dart';
import '../model/get_profile_model.dart';



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

  Future<DocumentPostModel> qualificationPost({
    required String document_title,
    required String document_type_id,
    required String expiry_date,
    File? document_file,
    String? oldProfileImage,
  }) async {
    final url = AppUrl.qualifications;

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

}