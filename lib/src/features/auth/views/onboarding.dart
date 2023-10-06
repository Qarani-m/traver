import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:traver/src/constants/app_strings.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/controllers/onboarding_controller.dart';
import 'package:traver/src/widget/auth/button.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    OnboardingController onboardingController = Get.put(OnboardingController());
    return Scaffold(
      body: PageView.builder(
        controller: onboardingController.pageController,
        itemCount: 3,
        itemBuilder:(BuildContext context, int index)=> Stack(
          children: [
            Container(
              height: AppSizes.appSize.height,
              width: AppSizes.appSize.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImageStrings.onboarding[index]),
                      fit: BoxFit.cover)),
            ),
            Container(
              
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
              height: AppSizes.appSize.height,
              width: AppSizes.appSize.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                      colors: [AppColors.darkColor, Colors.transparent])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.onboardingTitle[index], style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 40.sp,
                  color: AppColors.primaryColor
                ),),
                SizedBox(height: 50.h,),
                Text(AppStrings.onboardingSubTitle[index], style: GoogleFonts.urbanist(
                  color: AppColors.primaryColor,
                  fontSize: 16.sp,
      
                ),),
                SizedBox(height: 30.h,),
                AnimatedSmoothIndicator(
                activeIndex: index,
                count: 3,
                effect: WormEffect(
                    dotHeight: 2.0.h,
                    dotWidth: 100.w,
                    dotColor: AppColors.secondaryColor,
                    activeDotColor: AppColors.primaryColor),
                          ),
                SizedBox(height: 100.h,),
                LargeButton(text:index==2?"Get started": "Next", onTap: (){index==2?onboardingController.getStartedButton():onboardingController.nextButton();},)
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
