import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          body: controller.isLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Text(
                      controller.currentAddress.value,
                      style: TextStyle(fontSize: 20),
                    ),
                    controller.weatherModel.value != null
                        ? Text(
                            controller.weatherModel.value!.toJson().toString(),
                            style: TextStyle(fontSize: 20),
                          )
                        : const SizedBox(),
                  ],
                ),
        ),
      );
    });
  }
}
