import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/version_model.dart';

class VersionRepository {
  final _apiService = NetworkApiServices();

  Future<AppVersionModel> getAppVersionApi() async {
    try {
      final response = await _apiService.getApi(AppUrl.appVersion);
      print('response: $response');
      if (response != null) {
        return AppVersionModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }
}
