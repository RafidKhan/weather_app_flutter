import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ApiClient extends GetConnect {
  Future<Response?> getRequest({required String url}) async {
    try {
      final Response response = await get(url);

      final int? statusCode = response.statusCode;

      if (statusCode != null) {
        if (statusCode >= 200 && statusCode <= 299) {
          return response;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
