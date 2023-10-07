import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/trips/screens/about_trip.dart';
import 'package:traver/src/features/trips/screens/trips_details.dart';

class Trips extends StatelessWidget {
  const Trips({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    var brightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSizes.horizontalPadding,
          right: AppSizes.horizontalPadding,
          top: 50.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "List Your Trips",
              style: textTheme.titleMedium,
            ),
            SizedBox(
              height: 50.h,
            ),
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
            OneTrip(textTheme: textTheme, iconTheme: iconTheme),
            OneTrip(textTheme: textTheme, iconTheme: iconTheme),
            OneTrip(textTheme: textTheme, iconTheme: iconTheme),
            OneTrip(textTheme: textTheme, iconTheme: iconTheme),
          ],
        ),
      ),
    ));
  }
}

class OneTrip extends StatelessWidget {
  const OneTrip({
    super.key,
    required this.textTheme,
    required this.iconTheme,
  });

  final TextTheme textTheme;
  final IconThemeData iconTheme;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;

    return GestureDetector(
      onTap: () => Get.to(AboutTrip()),
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Container(
          padding:
              EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h, right: 10.w),
          decoration: BoxDecoration(
              border: Border.all(
                  color: brightness == Brightness.dark
                      ? AppColors.fadedTextColor.withOpacity(0.1)
                      : AppColors.fadedTextColor),
              borderRadius: BorderRadius.circular(20.r)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kuta beach",
                  style: textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 17.sp),
                ),
                GestureDetector(
                  onTap:()=> Get.to(TripsDetails()),
                    child: IconTheme(data: iconTheme, child: Icon(Icons.info)))
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Ksh 21900",
              style: textTheme.bodySmall?.copyWith(color: AppColors.likeColor),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconTheme(
                  data: iconTheme,
                  child: Icon(Icons.calendar_month),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "21 jun 2023",
                  style: textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "-",
                  style: textTheme.bodySmall?.copyWith(fontSize: 13.sp),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "27 jun 2023",
                  style: textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
