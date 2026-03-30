import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/cmsModel.dart';

class CmsRepository {
  final _apiService = NetworkApiServices();

  Future<CmsModel> getCmsApi() async {
    try {
      final response = await _apiService.getApi(AppUrl.getCms);
      print('response: $response');
      if (response != null) {
        return CmsModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }
}
