import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/features/auth/controllers/auth_controller.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController forgotPasswordController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  var name = "";
  var email = "";
  var phone = "";
  var password = "";
  RxBool isAuth = false.obs;
  RxBool showresetConfirmationEmail = false.obs;
  bool addToEmailList = true;

  void inputEmail() {
    name = "${firstNameController.text} ${lastNameController.text}";
    Get.toNamed("/registerEmail");
  }

  void createPassword() {
    phone = phoneController.text;
    email = emailController.text;
    Get.toNamed("/registerPassword");
  }

  Future<void> otpScreen() async {
    password = passwordController.text;
    isAuth.value = true;
    await authController.createUser(name, email, phone, password);
    isAuth.value = false;
  }

  Future<void> registerAction(int pin) async{
    password = passwordController.text;
    isAuth.value = true;

    await authController.createUser(name, email, phone, password);
    isAuth.value = false;

  }

  Future<void> forgotPassword() async {
    showresetConfirmationEmail.value = true;
    isAuth.value = true;
    await authController.resetPassword(forgotPasswordController.text);
    isAuth.value = false;
    showresetConfirmationEmail.value = true;
  }

  Rx<Color> borderColor = AppColors.fadedTextColor.withOpacity(0.5).obs;
  RxList<String> intrests = <String>[].obs;
  void intresetSelection(String intrest) async {
    borderColor.value = AppColors.accentColor;
    if (!intrests.contains(intrest)) {
      intrests.add(intrest);
    } else {
      intrests.remove(intrest);
    }
  }

   @override
void dispose() {
  Get.delete<SignUpController>(); // Dispose of the controller
  super.dispose();
}
}
