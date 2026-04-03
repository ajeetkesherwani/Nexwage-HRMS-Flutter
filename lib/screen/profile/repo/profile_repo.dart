import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/emergency_contact_model.dart';
import '../model/emergency_get_all_data_model.dart';
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

  Future<EmergencyGetAllDataModel> emergencyContactGetByIdDataApi(String id) async {
    try {
      final response = await _apiService.getApiWithToken("${AppUrl.emergencyContactPost}/${id}");
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


  Future<EmergencyContactModel> emergencyContactUpdateApi({
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

      final response = await _apiService.patchApiWithToken(
        "${AppUrl.emergencyContactPost}/$id",
        body,
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


}