import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/home/controller/searc_controller.dart';
import 'package:traver/src/features/home/widgets/popular_packages.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';

class FilterSearch extends StatefulWidget {
  const FilterSearch({super.key});

  @override
  State<FilterSearch> createState() => _FilterSearchState();
}

class _FilterSearchState extends State<FilterSearch> {
  // SfRangeValues _values = SfRangeValues(5000.0, 100000.0);
    SearchPageController searchPageController = Get.find<SearchPageController>();


  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    var brightness = MediaQuery.of(context).platformBrightness;
    var included = [
      "Flight",
      "Hotel",
      "Transport",
    ];
    int numStars = 6; // Set the initial number of stars

    var includedIcons = [
      Icons.flight_outlined,
      Icons.business,
      Icons.directions_bus_outlined
    ];

    Color  borderColor= brightness == Brightness.dark
                                            ? AppColors.fadedTextColor
                                                .withOpacity(0.051)
                                            : AppColors.darkColor
                                                .withOpacity(0.05) ;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            // left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            top: 60.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: AppSizes.horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopBar(
                      text: "Category",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Price range",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 19.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SfRangeSlider(
                stepSize: 100,
                startThumbIcon: Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.darkColor),
                      color: Colors.white,
                      shape: BoxShape.circle),
                ),
                endThumbIcon: Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.darkColor),
                      color: Colors.white,
                      shape: BoxShape.circle),
                ),
                activeColor: AppColors.darkColor,
                inactiveColor: AppColors.fadedTextColor,
                min: 5000.0,
                max: 100000.0,
                values: searchPageController.values.value,
                interval: 1000,
                showDividers: false,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (SfRangeValues values) {
                  setState(() {
                     searchPageController.values.value = values;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: AppSizes.horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Star review",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 19.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Column(
                      children: List.generate(
                        numStars - 1,
                        (index) {
                          numStars--;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: GestureDetector(
                              onTap: (){
                                print(index);
                               
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.w),
                                height: 55.h,
                                width: 390.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border:
                                      Border.all(color: AppColors.fadedTextColor),
                                ),
                                child: Row(
                                  children: List.generate(
                                    numStars,
                                    (index) => Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppColors.secondaryColor,
                                          size: 20.h,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      "What's Included ?",
                      style: textTheme.titleMedium?.copyWith(fontSize: 19.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        itemCount: included.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(left: 20.w, right: 20.w),
                                height: 50.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                        color:borderColor)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconTheme(
                                        data: iconTheme,
                                        child: Icon(
                                          includedIcons[index],
                                          color: AppColors.secondaryColor,
                                        )),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Text(
                                      included[index],
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
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 60.h,
                      width: 390.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.fadedTextColor),
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Text("Clear",
                                  style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Text("Search",
                                  style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
