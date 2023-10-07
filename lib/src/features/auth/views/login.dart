import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/controllers/login_controller.dart';
import 'package:traver/src/features/auth/widgets/text_field.dart';
import 'package:traver/src/widget/auth/button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            top: 150.h),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Align(child: Logo()),
            SizedBox(
              height: 60.h,
            ),
            TextFielAuth(
              controller: loginController.emailController,
              obscureText: false,
              label: "Email",
              hint: "Email",
            ),
            SizedBox(height: 20.h,),
            TextFielAuth(
              controller: loginController.passwordController,
              obscureText: loginController.obscureText.value,
              label: "Password",
              hint: "Password",
            ),
            GestureDetector(
                onTap: () {
                  Get.toNamed("forgotPassword");
                },
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot Password ?",
                        style: Theme.of(context).textTheme.bodySmall,
                        ))),
            SizedBox(height: 60.h,),
            LargeButton(text: "Sign In", onTap: (){
              loginController.loginAction();
            }),
            SizedBox(height: 10.h,),
            GestureDetector(
              onTap: () {loginController.createAccount();},
              child: Container(
                alignment: Alignment.center,
                height: 50.h,
                width: 390.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.fadedTextColor),
                    // color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Text(
                  "Create Account",
                  style:  Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            SizedBox(height: 50.h,),
        
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CircleAvatar( backgroundColor: AppColors.fadedTextColor.withOpacity(0.3), radius: 30.r,child: Icon(Icons.facebook, color: AppColors.darkColor, size: 50.h,)),
                  GestureDetector(
                    onTap: ()async{
                      await loginController.signInWithGoogle();
                    },
                    
                    child: CircleAvatar( backgroundColor: Colors.transparent, radius: 30.r,child:Image(image: AssetImage(AppImageStrings.google), height: 40.h,))),
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Obx(
                () => loginController.isAuth.value
                    ? Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: AppColors.secondaryColor, size: 30.h),
                      )
                    : Container(),
              )
        
          ]),
        ),
      ),
    );
  }
}


class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 8.h,
            left: 62.w,
            child: CircleAvatar(
              radius: 5.h,
              backgroundColor: AppColors.secondaryColor,
            )),
        Positioned(
            child: Text(
          "traver",
          style: Theme.of(context).textTheme.titleLarge,
        ))
      ],
    );
  }
}
