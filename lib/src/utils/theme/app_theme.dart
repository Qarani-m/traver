import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traver/src/constants/colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondaryColor),
        useMaterial3: true,
        fontFamily: "Urbanist",
        textTheme: TextTheme(
            titleLarge: TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 43.sp,
                fontWeight: FontWeight.w400),
            titleMedium: TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 27.sp,
                fontWeight: FontWeight.w600),
             titleSmall: TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600),
            //
            //
            bodyLarge: TextStyle(
              color: AppColors.darkTextColor.withOpacity(0.5),
              fontSize: 18.sp,
              fontWeight: FontWeight.w100,
            ),
            bodyMedium: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.w600,
            ),
            bodySmall: TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500)),

//
//
//

        iconTheme: IconThemeData(color: AppColors.darkColor, size: 25.h));
  }

  static ThemeData darkTheme() {
    return ThemeData(
        scaffoldBackgroundColor: AppColors.darkColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondaryColor),
        useMaterial3: true,
        fontFamily: "Urbanist",
        textTheme: TextTheme(
            titleLarge: TextStyle(
                color: AppColors.fadedTextColor,
                fontSize: 43.sp,
                fontWeight: FontWeight.w600),
            titleMedium: TextStyle(
                color: AppColors.fadedTextColor,
                fontSize: 27.sp,
                fontWeight: FontWeight.w600),
            titleSmall: TextStyle(
                color: AppColors.fadedTextColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w400),
            //
            //
            bodyLarge: TextStyle(
              color: AppColors.fadedTextColor.withOpacity(0.5),
              fontSize: 18.sp,
              fontWeight: FontWeight.w100,
            ),
            bodyMedium: TextStyle(
              color: AppColors.fadedTextColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.w600,
            ),
            bodySmall: TextStyle(
                color: AppColors.fadedTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500)),
        //
        //
        //
        iconTheme: IconThemeData(color: AppColors.fadedTextColor, size: 25.h));
  }
}
