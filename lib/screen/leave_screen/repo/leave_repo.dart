import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/leaveModel.dart';




class LeaveRepository {
  final _apiService = NetworkApiServices();

  Future<LeaveModel> getLeaveApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.leave);
      print('response: $response');
      if (response != null) {
        return LeaveModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }
}