import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/holiday_model.dart';




class HoliDayRepository {
  final _apiService = NetworkApiServices();

  Future<HolidayModel> getHoliDayApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.holiDay);
      print('response: $response');
      if (response != null) {
        return HolidayModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }

}