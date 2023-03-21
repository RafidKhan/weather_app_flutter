import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/app/data/utils/styles.dart';
import 'package:weather_app_flutter/app/modules/home/widgets/background_image.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  const BackGroundImage(),
                  controller.isLoading.isTrue
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black.withOpacity(0.3),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 20,
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (controller
                                    .currentAddress.value.isNotEmpty) ...[
                                  const Text(
                                    "Your address:",
                                    style: titleTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    controller.currentAddress.value,
                                    style: contentTextStyle,
                                  ),
                                ],
                                const SizedBox(
                                  height: 20,
                                ),
                                if (controller.weatherModel.value != null) ...[
                                  const Text(
                                    "Weather Detail:",
                                    style: titleTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Temperature: ",
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        "${controller.weatherModel.value!.currentWeather!.temperature!} °C",
                                        style: contentTextStyle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Wind Speed: ",
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        "${controller.weatherModel.value!
                                            .currentWeather!.windspeed!} km/h",
                                        style: contentTextStyle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Wind Direction: ",
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        controller.weatherModel.value!
                                            .currentWeather!.winddirection!
                                            .toString(),
                                        style: contentTextStyle,
                                      ),
                                    ],
                                  ),
                                ]
                              ],
                            ),
                          ),
                        ),
                ],
              )),
        ),
      );
    });
  }
}
