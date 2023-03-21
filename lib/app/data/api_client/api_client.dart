import 'package:get/get.dart';
import 'package:weather_app_flutter/app/data/common_methods.dart';

class ApiClient extends GetConnect {
  Future<Response?> getRequest({required String url}) async {
    try {
      final bool hasInternet = await checkInternetConnection();
      if (hasInternet) {
        final Response response = await get(url);

        final int? statusCode = response.statusCode;

        if (statusCode != null) {
          if (statusCode >= 200 && statusCode <= 299) {
            return response;
          }
        }
      } else {
        showToast("No Internet Connection");
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
