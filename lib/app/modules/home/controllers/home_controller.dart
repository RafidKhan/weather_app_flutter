import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/app/data/models/weather_model.dart';
import 'package:weather_app_flutter/app/modules/home/repository/home_repository.dart';

class HomeController extends GetxController {
  RxString currentAddress = "".obs;

  RxBool isLoading = false.obs;

  Rxn<WeatherModel> weatherModel = Rxn<WeatherModel>();

  HomeRepository homeRepository = HomeRepository();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getCurrentPosition();
    super.onReady();
  }

  Future<void> getCurrentPosition() async {
    isLoading.value = true;
    bool hasMapPermission = await checkMapPermission(Get.context!);
    if (hasMapPermission) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        final Position currentPosition = position;
        await getCurrentWeatherData(currentPosition);

        await placemarkFromCoordinates(
                currentPosition.latitude, currentPosition.longitude)
            .then((List<Placemark> placeMarks) {
          if (placeMarks.isNotEmpty) {
            final Placemark place = placeMarks.first;
            currentAddress.value =
                '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
          }
        });
      } catch (e) {
        isLoading.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
          ),
        );
      }
    }
  }

  Future<bool> checkMapPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future getCurrentWeatherData(Position position) async {
    try {
      final String latitude = position.latitude.toString();
      final String longitude = position.longitude.toString();
      final WeatherModel? response = await homeRepository.getCurrentWeatherData(
          lat: latitude, long: longitude);
      if (response != null) {
        weatherModel.value = response;
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
