import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traver/src/constants/app_strings.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/controllers/signup_controller.dart';
import 'package:traver/src/features/auth/widgets/question.dart';
import 'package:traver/src/features/auth/widgets/text_field.dart';
import 'package:traver/src/widget/auth/button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterName extends StatelessWidget {
  const RegisterName({super.key});

  @override
  Widget build(BuildContext context) {
    final formGlobalKey = GlobalKey<FormState>();
    SignUpController signUpController = Get.put(SignUpController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: AppSizes.horizontalPadding,
              right: AppSizes.horizontalPadding,
              top: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GobackBtn(),
              SizedBox(
                height: 80.h,
              ),
              const Question(
                question: "What's your name?",
              ),
              SizedBox(
                height: 60.h,
              ),
              Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    TextFielAuth(
                        controller: signUpController.firstNameController,
                        obscureText: false,
                        label: "First Name",
                        hint: ""),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFielAuth(
                      controller: signUpController.lastNameController,
                      obscureText: false,
                      label: "Last Name",
                      hint: "",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              SizedBox(
                height: 30.h,
              ),
              LargeButton(
                  text: "Input Email",
                  onTap: () {
                    if (formGlobalKey.currentState!.validate()) {
                      signUpController.inputEmail();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class GobackBtn extends StatelessWidget {
  const GobackBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
            Get.back();
      },
      child: IconTheme(
        data: Theme.of(context).iconTheme,
        child: Icon(
          Icons.arrow_back,
          size: 30.h,
          weight: 1,
        ),
      ),
    );
  }
}

class RegisterEmail extends StatelessWidget {
  const RegisterEmail({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    final formGlobalKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: AppSizes.horizontalPadding,
              right: AppSizes.horizontalPadding,
              top: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GobackBtn(),
              SizedBox(
                height: 80.h,
              ),
              const Question(
                question: "And your Email + Phone Number? ",
              ),
              SizedBox(
                height: 30.h,
              ),
              Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    TextFielAuth(
                        controller: signUpController.emailController,
                        obscureText: false,
                        label: "Email",
                        hint: ""),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFielAuth(
                        controller: signUpController.phoneController,
                        obscureText: false,
                        label: "Phone",
                        hint: ""),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 290.w,
                    // color: Colors.red,
                    child: Text(
                      AppStrings.marketingEmails,
                      style: GoogleFonts.urbanist(
                          // color: AppColors.fadedTextColor,
                          fontSize: 14.sp),
                    ),
                  ),
                  Checkbox(
                      activeColor: AppColors.secondaryColor,
                      side: BorderSide(color: AppColors.darkColor),
                      value: true,
                      onChanged: (val) {})
                  // Radio(value: true, groupValue: true, onChanged: (val){})
                ],
              ),
              SizedBox(
                height: 70.h,
              ),
              LargeButton(
                  text: "Create Password",
                  onTap: () {
                    if (formGlobalKey.currentState!.validate()) {
                      signUpController.createPassword();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPassword extends StatelessWidget {
  const RegisterPassword({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    final formGlobalKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: AppSizes.horizontalPadding,
              right: AppSizes.horizontalPadding,
              top: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                      Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30.h,
                  weight: 1,
                  color: AppColors.darkColor,
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              const Question(
                question: "Create Password",
              ),
              SizedBox(
                height: 60.h,
              ),
              Form(
                key: formGlobalKey,
                child: TextFielAuth(
                    controller: signUpController.passwordController,
                    obscureText: true,
                    label: "Password",
                    hint: ""),
              ),
              Text(
                AppStrings.passwordValidation,
                style: GoogleFonts.urbanist(
                    // color: AppColors.fadedTextColor,
                    fontSize: 14.sp),
              ),
              SizedBox(
                height: 70.h,
              ),
              LargeButton(
                  text: "verification",
                  onTap: () {
                    if (formGlobalKey.currentState!.validate()) {
                      signUpController.otpScreen();
                    }
                  }),
              SizedBox(
                height: 100,
              ),
              Obx(
                () => signUpController.isAuth.value
                    ? Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: AppColors.secondaryColor, size: 30.h),
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterVerification extends StatelessWidget {
  const RegisterVerification({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: AppSizes.horizontalPadding,
              right: AppSizes.horizontalPadding,
              top: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80.h,
              ),
              const Question(
                question: "Otp verification",
              ),
              SizedBox(height: 10.h),
              Text(
                  "Enter otp code sent to ${signUpController.phoneController.text}",
                  style: Theme.of(context).textTheme.bodySmall),
              SizedBox(
                height: 60.h,
              ),
              SizedBox(
                height: 60.h,
                width: 390.w,
                // color: Colors.red,
                child: OTPTextField(
                  length: 5,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 50,
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {
                    signUpController.registerAction(int.parse(pin));
                  },
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              LargeButton(
                  text: "Submit",
                  onTap: () {
                    Get.offNamed("registerSucces");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class Succes extends StatelessWidget {
  const Succes({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            top: 60.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(
              height: 250.h,
              width: 300.w,
              // color: Colors.red,
              child: Lottie.asset(repeat: false, 'assets/svgs/succes.json'),
            ),
            SizedBox(height: 50.h),
            Text("Succesfully created an account",
            textAlign: TextAlign.center,
                style:Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: 10.h,
            ),
            Text("After this you can explore any place you want, enjoy",
            textAlign: TextAlign.center,
              
                style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: 50.h),
            LargeButton(
                text: "Let's Explore",
                onTap: ()async {


                  Get.offNamed("explore");
                })
          ],
        ),
      ),
    );
  }
}
