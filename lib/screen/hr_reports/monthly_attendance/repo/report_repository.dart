import '../../../../WebServices/app_url.dart';
import '../../../../WebServices/network/network_api_services.dart';
import '../model/annual_attendance_model.dart';
import '../model/monthly_attendance_model.dart';

class ReportRepository {
  final _apiService = NetworkApiServices();

  Future<AttendanceResponse> getMonthlyAttendance() async {
    try {
      final response = await _apiService.getApiWithToken(
        AppUrl.getMonthlyAttendance,
      );
      print('response: $response');
      if (response != null) {
        return AttendanceResponse.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }

  Future<AnnualAttendanceResponse> getAnnualAttendance(data) async {
    try {
      final response = await _apiService.postApiWithToken(
        data,
        AppUrl.annualReport,
      );
      print('response: $response');
      if (response != null) {
        return AnnualAttendanceResponse.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }
}
