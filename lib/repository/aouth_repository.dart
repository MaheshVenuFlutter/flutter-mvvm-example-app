import 'package:mvvm_example/data/network/base_api_service.dart';
import 'package:mvvm_example/data/network/network_api_service.dart';
import 'package:mvvm_example/res/app_url.dart';

class AouthRepository {
  BaseApiService _apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.getPostApiResponse(AppUrl.loginEndpoint, data);

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> regesterApi(dynamic data) async {
    try {
      dynamic response = await _apiService.getPostApiResponse(
          AppUrl.registrationEndpoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
