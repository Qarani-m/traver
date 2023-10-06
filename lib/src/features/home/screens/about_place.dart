import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parsed_readmore/parsed_readmore.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';

class AboutPlace extends StatelessWidget {
  const AboutPlace({super.key});

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
    late GoogleMapController mapController;

    final LatLng _center = const LatLng(45.521563, -122.677433);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

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
                                      color:
                                          AppColors.darkColor.withOpacity(0.5),
                                      borderRadius:
                                          BorderRadius.circular(20.r)),
                                  child: Center(
                                    child: Text(
                                      "19+",
                                      style: textTheme.titleMedium,
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition:const  CameraPosition(
                    target:  LatLng(45.521563, -122.677433),
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
            ],
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar(
      {super.key,
      required this.text,
      this.widget = const SizedBox(
        width: 20,
      )});
  final String text;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: () => Get.back(),
        child: IconTheme(
          data: iconTheme,
          child: const Icon(Icons.arrow_back),
        ),
      ),
      Text(
        "Kuta beach",
        style: textTheme.bodyMedium,
      ),
      widget
    ]);
  }
}



// AIzaSyCJBO0XfD0AvZXpo_0UVTr2oBE1pL10TGk