import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/attendance_model.dart';
import '../model/panchOut_model.dart';
import '../model/today_attendance_model.dart';

class AttendanceRepository {
  final _apiService = NetworkApiServices();

  Future<AttendanceModel> PostAttendance({
    required double latitude,
    required double longitude,
    required String device_id,
    required String timestamp,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "latitude": latitude,
        "longitude": longitude,
        "device_id": device_id,
        "timestamp": timestamp,
      };

      final response = await _apiService.postApiWithToken(
        body,
        "${AppUrl.postAttendance}",
      );

      print('response: $response');

      if (response != null) {
        return AttendanceModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error sending data: $e');
      rethrow;
    }
  }

  Future<PanchOutModel> PostAttendanceOut({
    required double latitude,
    required double longitude,
    required String timestamp,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "latitude": latitude,
        "longitude": longitude,
        "timestamp": timestamp,
      };

      final response = await _apiService.postApiWithToken(
        body,
        "${AppUrl.panchOut}",
      );

      print('response: $response');

      if (response != null) {
        return PanchOutModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error sending data: $e');
      rethrow;
    }
  }

  Future<TodayAttendanceModel> getTodayAttendance() async {
    try {
      final response = await _apiService.getApiWithToken(
        AppUrl.todayAttendance,
      );
      print('response: $response');
      if (response != null) {
        return TodayAttendanceModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }

  Future<dynamic> getPublicTime() async {
    try {
      final response = await _apiService.getApi(
        "https://timeapi.io/api/Time/current/zone?timeZone=Asia/Kolkata",
      );
      print('response: $response');
      if (response != null) {
        return response['dateTime'];
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }
}
