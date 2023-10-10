import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/features/auth/controllers/login_controller.dart';

class TextFielAuth extends StatelessWidget {
  const TextFielAuth({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.label,
    required this.hint,
    this.readonly=false,
    this.numberKeyboard = false,
    this.massiveSpace=true,

  });

  final TextEditingController controller;
  final bool obscureText;
  final String label;
  final String hint;
  final bool readonly;
  final bool numberKeyboard;
  final bool massiveSpace;


  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Container(
      // color: Colors.red,
      height: massiveSpace? 75.h:55.h,
      child: Obx(
        () => TextFormField(
          keyboardType: numberKeyboard?TextInputType.number:TextInputType.text,
          validator: (value) {
            switch (label) {
              case "First Name" || "Last Name":
                if (InputValidation.isValidName(value ?? "")) {
                  return null;
                } else {
                  return "Invalid name! Name should be have atleast 3 characters";
                }
              case "Email":
                if (InputValidation.isValidEmail(value ?? "")) {
                  return null;
                } else {
                  return "Invalid email!";
                }
              case "Phone":
                if (InputValidation.isValidPhoneNumber(value ?? "")) {
                  return null;
                } else {
                  return "Inavalid phone number";
                }

              case "Password":
                if (InputValidation.isValidPassword(value ?? "")) {
                  return null;
                } else {
                  return "Invalid Password! password should have atleast 8 characters";
                }
                default:
                  return "something is wrong";
            }
          },
          readOnly: readonly,
          controller: controller,
          obscureText: loginController.obscureText.value && label == "Password",
          obscuringCharacter: "●",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15.sp),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: 23.w, top: 15.h, bottom: 15.h),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors
                      .secondaryColor), // Set the border color when focused
              borderRadius:
                  BorderRadius.circular(20.r), // Set the border radius
            ),
            focusedErrorBorder:OutlineInputBorder(
              borderRadius:  BorderRadius.circular(15.h),
              
              borderSide: BorderSide(color: Color(0xFFdc143c)),

            ) ,
            errorBorder:  OutlineInputBorder(
              borderRadius:  BorderRadius.circular(15.h),
                borderSide: BorderSide(color: Color(0xFFdc143c))),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors
                      .fadedTextColor), // Set the border color when not focused
              borderRadius:
                  BorderRadius.circular(15.h), // Set the border radius
            ),
            hintMaxLines: 1,
            labelStyle:Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15.sp) ,
            labelText: label,
            suffixIcon: obscureText
                ? GestureDetector(
                    onTap: () => loginController.toggleVisibility(),
                    child: IconTheme(
                      data: Theme.of(context).iconTheme,
                      child: Icon(
                        loginController.obscureText.value
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class InputValidation {
  static bool isValidName(String name) {
    bool nameValidate = name.length >= 3 && RegExp(r'^[a-zA-Z ]+$').hasMatch(name.trim());
    print(name.trim());
    return nameValidate;
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
        .hasMatch(email.trim());
  }

  static bool isValidPassword(String password) {
    return password.length >= 8;
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^07\d{8}$').hasMatch(phoneNumber.trim());
  }

  static String validationResults(
      String name, String email, String phoneNumber, String password) {
    String message = "";
    if (!isValidName(name)) {
      message = "Invalid name! Name should be have atleast 3 characters";
    } else if (!isValidEmail(email)) {
      message = "Invalid email!";
    } else if (!isValidPassword(password)) {
      message = "Invalid Password! password should have atleast 8 characters";
    } else if (!isValidPhoneNumber(phoneNumber)) {
      message = "Inavalid phone number";
    } else {
      message = "pass";
    }
    return message;
  }
}
