import 'dart:developer';

import 'package:get/get_connect.dart';
import 'package:weather_app_flutter/app/data/api_client/api_client.dart';
import 'package:weather_app_flutter/app/data/models/weather_model.dart';

class HomeRepository extends ApiClient {
  Future<WeatherModel?> getCurrentWeatherData({
    required String lat,
    required String long,
  }) async {
    try {
      final String url =
          "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&current_weather=true";
      final Response? response = await getRequest(url: url);
      if (response != null) {
        return WeatherModel.fromJson(response.body);
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
