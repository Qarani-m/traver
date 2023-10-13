import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/controllers/signup_controller.dart';
import 'package:traver/src/widget/auth/button.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            top: 40.h),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text("Where is your favourite place to explore?",
              style: Theme.of(context).textTheme.titleMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Intrest(text: "Beach", image: AppImageStrings.explore[0]),
              Intrest(text: "Mountain", image: AppImageStrings.explore[1]),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Intrest(text: "Forest", image: AppImageStrings.explore[2]),
              Intrest(text: "Ocean", image: AppImageStrings.explore[3]),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Intrest(text: "Camping", image: AppImageStrings.explore[4]),
              Intrest(text: "Wildlife", image: AppImageStrings.explore[5]),
            ],
          ),
          LargeButton(
              text: "Next",
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("goToHomePage", true);
                prefs.setStringList("intrests", signUpController.intrests);
                Get.offNamed("homepage");
              })
        ]),
      ),
    );
  }
}

class Intrest extends StatelessWidget {
  const Intrest({
    required this.text,
    required this.image,
    super.key,
  });
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());

    return Obx(
      () => GestureDetector(
        onTap: () {
          signUpController.intresetSelection(text);
        },
        child: Container(
          alignment: Alignment.center,
          height: 170.h,
          width: 160.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                  width: signUpController.intrests.contains(text) ? 2 : 1,
                  color: signUpController.intrests.contains(text)
                      ? AppColors.secondaryColor
                      : AppColors.fadedTextColor.withOpacity(0.5))),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(image), height: 60.h, width: 60.w),
                  SizedBox(height: 15.h,),
                  Text(text,style:Theme.of(context).textTheme.titleSmall),
                ],
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
          // DropShadowImage(child: Image(image: AssetImage(AppImageStrings.explore[0]), height: 100.h, width: 100.w,)),
