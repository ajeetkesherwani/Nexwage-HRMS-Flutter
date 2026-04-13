import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/categories_model.dart';
import '../model/get_reimbursement_model.dart';
import '../model/reimbursement_post_model.dart';


class ReimbursementRepository {
  final _apiService = NetworkApiServices();

  Future<CategoriesModel> getCategoriesApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.categories);
      print('response: $response');
      if (response != null) {
        return CategoriesModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }
//ReimbursementPostModel

  Future<ReimbursementPostModel> postReimbursementDetails({
    required String category_id,
    required String amount,
    required String description,
    required String start_date,
    required String end_date,
    File? receipt_file,
    String? oldProfileImage,
  }) async {
    final url = AppUrl.reimbursements;

    try {
      final fields = {
        "category_id": category_id,
        "amount": amount,
        "description": description,
        "start_date": start_date,
        "end_date": end_date,
      };

      if (receipt_file == null && oldProfileImage != null) {
        fields["attachment"] = oldProfileImage;
      }
      final files = <String, File>{};
      if (receipt_file != null) {
        files["attachment"] = receipt_file;
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
      return ReimbursementPostModel.fromJson(response);
    } catch (e) {
      log(" experience API Error => $e");
      rethrow;
    }
  }




  Future<GetReimbursementModel> getReimbursementApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.reimbursements);
      print('response: $response');
      if (response != null) {
        return GetReimbursementModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }
}