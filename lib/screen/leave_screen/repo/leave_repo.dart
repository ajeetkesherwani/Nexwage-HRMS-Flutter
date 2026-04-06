import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/apply_leave_model.dart';
import '../model/leaveModel.dart';
import '../model/leave_type_model.dart';
import '../model/withdrawnmodel.dart';




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
  Future<LeaveTypeModel> getLeaveTypeApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.leaveType);
      print('response: $response');
      if (response != null) {
        return LeaveTypeModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }

  Future<WithdrawnModel> getWithdrawnApi({required String id}) async {
    try {
      final response = await _apiService.getApiWithToken("${AppUrl.leaveType}/$id");
      print('response: $response');
      if (response != null) {
        return WithdrawnModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }

  Future<ApplyLeaveModel> applyLeave({
    required String leave_type_id,
    required String start_date,
    required String end_date,
    required String reason,
    required bool is_half_day,
    File? attachment,
    String? oldProfileImage,
  }) async {
    final url = AppUrl.applyLeave;

    try {
      final fields = {
        "leave_type_id": leave_type_id,
        "start_date": start_date,
        "end_date": end_date,
        "reason": reason,
        "is_half_day": is_half_day.toString(),
      };

      if (attachment == null && oldProfileImage != null) {
        fields["attachment"] = oldProfileImage;
      }
      final files = <String, File>{};
      if (attachment != null) {
        files["attachment"] = attachment;
      }
      if (kDebugMode) {
        log("📤 Fields => $fields");
        log("🖼 Files => ${files.keys}");
      }

      final response =
      await _apiService.patchMultipartMultiImageApiWithToken(
        url: url,
        fields: fields,
        files: files,
      );
      return ApplyLeaveModel.fromJson(response);
    } catch (e) {
      log(" Apply Leave API Error => $e");
      rethrow;
    }
  }

}