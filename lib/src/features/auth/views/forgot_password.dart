import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/controllers/signup_controller.dart';
import 'package:traver/src/features/auth/views/register.dart';
import 'package:traver/src/features/auth/widgets/question.dart';
import 'package:traver/src/features/auth/widgets/text_field.dart';
import 'package:traver/src/widget/auth/button.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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
              GobackBtn(),
              SizedBox(
                height: 80.h,
              ),
              const Question(
                question: "Forgot your password?",
                forgotPassword:true
              ),
              SizedBox(
                height: 60.h,
              ),
              TextFielAuth(
                  controller: signUpController.forgotPasswordController,
                  obscureText: true,
                  label: "Email",
                  hint: ""),
              Obx(()=> !signUpController.showresetConfirmationEmail.value?Text(
                  textAlign:TextAlign.center,
                  "Enter your email Address to recieve the password reset link",
                  style: Theme.of(context).textTheme.bodySmall,
                ) : Text(
                  textAlign:TextAlign.center,
                  "An Email with password reset link has been sent to '${signUpController.forgotPasswordController.text}'",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              LargeButton(
                  text: "Submit",
                  onTap: () {
                    signUpController.forgotPassword();
                  }),
                  SizedBox(height: 50.h,),
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
