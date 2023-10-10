import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/home/models/destination_model.dart';
import 'package:traver/src/features/home/screens/about_place.dart';
import 'package:traver/src/features/home/widgets/popular_packages.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
        var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    var brightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      body: Padding(
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
                SizedBox(height: 30.h,),
                GestureDetector(
                  onTap: ()=> Get.to(AboutPlace()),
                  child: PopularPackage(
                     destinationModel: DestinationModel(
                              destinationId: "${18}",
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/traver-79d4b.appspot.com/o/destinations%2Fpexels-photo-5372613.jpeg?alt=media&token=65c42c57-6705-4ed2-92a4-5f087c010630&_gl=1*gthss5*_ga*OTU2MDYyODE5LjE2OTYzNTE3MTQ.*_ga_CW55HF8NVT*MTY5Njg0MzI2MC4yMy4xLjE2OTY4NDM0ODAuMzcuMC4w",
                              starCount: "3.8",
                              location: "Bali Indonesia",
                              name: "Kuta beach")
                  ))
          ],
        ),

      )
      
      );
  }
}