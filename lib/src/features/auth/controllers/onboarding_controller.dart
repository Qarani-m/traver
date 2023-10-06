import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();

  void nextButton() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300), // You can adjust the duration
      curve: Curves.bounceIn,
    );
  }

  void getStartedButton() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirstTimer", true);
    Get.offNamed(
      "/login"
    );
  }

  @override
  void onClose() {
    pageController.dispose(); // Dispose of the PageController
    super.onClose();
  }
}
