import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';

class Trips extends StatelessWidget {
  const Trips({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var iconTheme =Theme.of(context).iconTheme;
    var brightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            top: 50.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("List Your Trips", style: textTheme.titleMedium,),
              SizedBox(height: 50.h,),
              SizedBox(
                height: 60.h,
                width: 390.w,
                child: TextField(
                  style: textTheme.bodySmall?.copyWith(fontSize: 17.sp),
                  cursorColor: brightness == Brightness.dark
                      ? AppColors.fadedTextColor
                      : AppColors.darkColor,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 23.w, top: 15.h, bottom: 15.h),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: brightness == Brightness.dark
                                ? AppColors.fadedTextColor.withOpacity(0.1)
                                : AppColors
                                    .fadedTextColor), // Set the border color when focused
                        borderRadius: BorderRadius.circular(
                            20.r), // Set the border radius
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: brightness == Brightness.dark
                                ? AppColors.fadedTextColor.withOpacity(0.1)
                                : AppColors
                                    .fadedTextColor), // Set the border color when not focused
                        borderRadius: BorderRadius.circular(
                            15.h), // Set the border radius
                      ),
                      hintMaxLines: 1,
                      hintText: "Search destination",
                      hintStyle: textTheme.bodySmall),
                )),
              SizedBox(
                height: 30.h,
              ),

            ],
          ),
          
          ),
      )
    );
  }
}