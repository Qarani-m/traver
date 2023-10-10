import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parsed_readmore/parsed_readmore.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/booking/screens/booking_details.dart';
import 'package:traver/src/features/home/widgets/review.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';

class AboutPlace extends StatelessWidget {
   AboutPlace({super.key});

    late GoogleMapController mapController;


 void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }





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
    var includedIcons = [
      Icons.flight_outlined,
      Icons.business,
      Icons.directions_bus_outlined
    ];
    const String inputData =
        "When using custom values we have specified the to be our targe have specified the to be our targe have specified the to be our targe have specified the to be our targe have specified the to be our target text for highlighting  with purple italic font. We know that the website is a very useful website. (rti..notNow should not be parsed) But Instagram is more fun to use. We should not forget the contribution of wikipedia played in the growth of web. If you like this package do consider liking it so that it could be useful to more developers like you. Thank you for your time";
   
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 60.h,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: AppSizes.horizontalPadding,
                  right: AppSizes.horizontalPadding,
                  top: 50.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(
                        text: "Kuta beach",
                        widget: IconTheme(
                            data: iconTheme,
                            child: Icon(
                              Icons.favorite,
                              color: AppColors.likeColor,
                            ))),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      height: 210.h,
                      width: 390.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          image: DecorationImage(
                              image: AssetImage(AppImageStrings.onboarding[2]),
                              fit: BoxFit.cover)),
                      child: Container(
                          height: 210.h,
                          width: 390.w,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  AppColors.darkColor.withOpacity(0.5),
                                  Colors.transparent
                                ]),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Text("Kuta beach",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.white)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Text(
                                    "100+ people have reviewed",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconTheme(
                                        data: Theme.of(context).iconTheme,
                                        child: const Icon(
                                            Icons.location_on_outlined)),
                                    Text(
                                      "Bali,",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    Text("Indonesia",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.white))
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RatingBar.builder(
                                        unratedColor: Colors.white,
                                        initialRating: 4.3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemSize: 20.h,
                                        onRatingUpdate: (rating) {},
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "4.8",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ])),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "What's Included ?",
                      style: textTheme.titleMedium?.copyWith(fontSize: 19.sp),
                    ),
                    SizedBox(
                      height: 20.h,
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
                                        color: brightness == Brightness.dark
                                            ? AppColors.fadedTextColor
                                                .withOpacity(0.051)
                                            : AppColors.darkColor
                                                .withOpacity(0.05))),
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
                    Text(
                      "About Trip",
                      style: textTheme.titleMedium?.copyWith(fontSize: 19.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      child: ParsedReadMore(
                        inputData,
                        trimMode: TrimMode.line,
                        trimLines: 3,
                        delimiterStyle: Theme.of(context).textTheme.bodyMedium,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(height: 1.6, fontSize: 13.sp),
                        trimCollapsedText: 'read more',
                        trimExpandedText: 'hide',
                        moreStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.secondaryColor),
                        lessStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.secondaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Gallery Photo",
                      style: textTheme.titleMedium?.copyWith(fontSize: 19.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          3,
                          (index) => Container(
                                height: 100.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            AppImageStrings.onboarding[2])),
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20.r)),
                                child: index == 2
                                    ? Container(
                                        height: 100.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.darkColor
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(20.r)),
                                        child: Center(
                                          child: Text(
                                            "19+",
                                            style: textTheme.titleMedium
                                                ?.copyWith(
                                                    color: AppColors
                                                        .fadedTextColor),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              )),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Location",
                      style: textTheme.titleMedium?.copyWith(fontSize: 19.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 210,
                      width: 390,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r)),
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(45.521563, -122.677433),
                          zoom: 11.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Reviews (99)",
                      style: textTheme.titleMedium?.copyWith(fontSize: 19.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Review(),
                    Review(),
                    Review(),
                    Review(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
            // color: Colors.red,
            height: 60.h,
            width: 390.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Ksh 21900",
                      style: textTheme.titleSmall?.copyWith(
                          color: AppColors.likeColor, fontSize: 21.sp),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "/person",
                      style: textTheme.bodySmall,
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const Bookingdetails());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Text("Booking", style: textTheme.titleSmall),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}





// AIzaSyCJBO0XfD0AvZXpo_0UVTr2oBE1pL10TGk