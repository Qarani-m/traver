import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/home/models/destination_model.dart';
import 'package:traver/src/features/home/screens/about_place.dart';
import 'package:traver/src/features/home/screens/filter.dart';
import 'package:traver/src/features/home/widgets/popular_packages.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';

class Categorys extends StatelessWidget {
  const Categorys({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> explore = [
      "Beach",
      "Mountain",
      "Forest",
      "Resort",
      "Camping",
      "Wildlife"
    ];
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            top: 60.h,
          ),
          child: Column(
            children: [
              TopBar(
                text: "Category",
                widget: GestureDetector(
                  onTap: ()=> Get.to(const FilterSearch()),
                  child: IconTheme(data: iconTheme, child: const Icon(Icons.tune))),
              ),
              SizedBox(
                height: 30.h,
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
                        contentPadding: EdgeInsets.only(
                            left: 23.w, top: 15.h, bottom: 15.h),
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
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  itemCount: explore.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          height: 50.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                  color: brightness == Brightness.dark
                                      ? AppColors.fadedTextColor
                                          .withOpacity(0.051)
                                      : AppColors.darkColor.withOpacity(0.05))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      AppImageStrings.explore[index])),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                explore[index],
                                style: textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                          width: 10.w,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: ()=> Get.to( AboutPlace()),
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
        ),
      ),
    );
  }
}
