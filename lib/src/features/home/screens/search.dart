import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/home/widgets/popular_packages.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var brightness = MediaQuery.of(context).platformBrightness;
    var iconTheme = Theme.of(context).iconTheme;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSizes.horizontalPadding,
          right: AppSizes.horizontalPadding,
          top: 60.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBar(text: "search"),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
                height: 60.h,
                width: 390.w,
                child: TextField(
                  style: textTheme.bodySmall?.copyWith(fontSize: 17.sp),
                  autofocus: true,
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
              height: 20.h,
            ),
           
            Column(
              children: List.generate(4, (index) => Padding(
                padding:  EdgeInsets.only( top: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          IconTheme(data: iconTheme,
                          child: Icon(Icons.schedule)),
                          SizedBox(width: 10.w,),
                          Text("kuta beach", style: textTheme.bodySmall,)
                        ],
                      ),
                    ),
                    IconTheme(data: iconTheme,
                          child: Icon(Icons.close)),
                  ],
                ),
              )),
            ),
            SizedBox(
              height: 30.h,
            ),

            Text(
              "We found 4 trips for 'bali'",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 19.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            PopularPackage()
          ],
        ),
      ),
    ));
  }
}
