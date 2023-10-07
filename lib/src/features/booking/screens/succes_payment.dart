
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/widget/auth/button.dart';

class SuccessPayment extends StatelessWidget {
  const SuccessPayment({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            top: 50.h),
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
            Text("Booking succesful",
            textAlign: TextAlign.center,
                style:Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: 10.h,
            ),
            Text("E-reciept sent to 'emqarani@gmail'",
            textAlign: TextAlign.center,
              
                style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: 50.h),
            LargeButton(
                text: "Continue Exploring",
                onTap: ()async {


                  Get.offNamed("explore");
                })
          ],
        ),
      ),
    );
  }
}
