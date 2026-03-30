import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/home_model.dart';




class HomeRepository {
  final _apiService = NetworkApiServices();

  Future<HomeModel> getHomeApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.home);
      print('response: $response');
      if (response != null) {
        return HomeModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }

}