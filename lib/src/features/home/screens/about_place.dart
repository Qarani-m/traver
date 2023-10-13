import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parsed_readmore/parsed_readmore.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/booking/screens/booking_details.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';
import 'package:traver/src/features/home/models/destination_model.dart';
import 'package:traver/src/features/home/models/review_model.dart';
import 'package:traver/src/features/home/widgets/review.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';

class AboutPlace extends StatelessWidget {
  AboutPlace({super.key});

  late GoogleMapController mapController;

  HomePageController homePageController = Get.find<HomePageController>();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    var brightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
        body: FutureBuilder<DestinationModel>(
            future: homePageController
                .getPlaceDetails(Get.arguments["destinationId"] ?? "NULL"),
            builder: (BuildContext context,
                AsyncSnapshot<DestinationModel> snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                        color: AppColors.secondaryColor.withOpacity(0.5),
                        size: 30.h));
              } else if (snapShot.hasError) {
                return Center(
                  child: Text("An error occured,", style: textTheme.bodySmall),
                );
              } else {
                final destinationData = snapShot.data;
                final List<dynamic> dynamicData =
                    destinationData!.whatsIncluded!;

                final List<Map<String, bool>> whatsIncluded =
                    dynamicData.map((item) {
                  // Here, we assume that each item in dynamicData is a Map<String, bool>
                  final Map<String, bool> itemData =
                      Map<String, bool>.from(item);

                  return {
                    itemData.keys.first: itemData.values.first,
                  };
                }).toList();

                return
                    //     }
                    // })

                    Column(
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
                                  text: "${destinationData?.name}",
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
                                        image: AssetImage(
                                            AppImageStrings.onboarding[2]),
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
                                            AppColors.darkColor
                                                .withOpacity(0.5),
                                            Colors.transparent
                                          ]),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.h),
                                            child: Text(
                                                "${destinationData?.name}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.white)),
                                          ),
                                          Container(
                                            // color: Colors.red,
                                            width: 280.w,
                                            padding: EdgeInsets.only(
                                                left: 5.h,
                                                top: 3.h,
                                                bottom: 3.h),
                                            child: Text(
                                              "${destinationData?.mantra}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 13.sp),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconTheme(
                                                  data: Theme.of(context)
                                                      .iconTheme,
                                                  child: const Icon(Icons
                                                      .location_on_outlined)),
                                              Text(
                                                "${destinationData?.location?.split(" ")[0]}, ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 5.h,
                                              ),
                                              Text(
                                                  "${destinationData?.location?.split(" ")[1]}, ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                          color: Colors.white))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 4.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                RatingBar.builder(
                                                  unratedColor: Colors.white,
                                                  initialRating: double.parse(
                                                      "${destinationData?.starCount}"),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
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
                                                  "${destinationData?.starCount}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                          color: Colors.white),
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
                                style: textTheme.titleMedium
                                    ?.copyWith(fontSize: 19.sp),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                height: 50.h,
                                child: ListView.builder(
                                  itemCount: whatsIncluded.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item = whatsIncluded[index];
                                    final key = item.keys.first;
                                    // final icon = item?[key];
                                    return Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20.w, right: 20.w),
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              border: Border.all(
                                                  color: brightness ==
                                                          Brightness.dark
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
                                                    homePageController
                                                        .whatsIncludedIcons(
                                                            key),
                                                    // Icons.flight_outlined,
                                                    // icon,
                                                    // includedIcons[index],
                                                    color: AppColors
                                                        .secondaryColor,
                                                  )),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              Text(
                                                // destinationDa
                                                key,
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
                                style: textTheme.titleMedium
                                    ?.copyWith(fontSize: 19.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                child: ParsedReadMore(
                                  "${destinationData?.about}",
                                  trimMode: TrimMode.line,
                                  trimLines: 3,
                                  delimiterStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(height: 1.6, fontSize: 13.sp),
                                  trimCollapsedText: 'read more',
                                  trimExpandedText: 'hide',
                                  moreStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: AppColors.secondaryColor),
                                  lessStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: AppColors.secondaryColor),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                "Gallery Photos",
                                style: textTheme.titleMedium
                                    ?.copyWith(fontSize: 19.sp),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                    3,
                                    (index) => Container(
                                          height: 100.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                    "${destinationData?.gallery?[index]}",
                                                  )),
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          child: index == 2 &&
                                                  (destinationData?.gallery
                                                              ?.length)! -
                                                          3 !=
                                                      0
                                              ? Container(
                                                  height: 100.h,
                                                  width: 100.w,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.darkColor
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r)),
                                                  child: Center(
                                                    child: Text(
                                                      "${(destinationData?.gallery?.length)! - 3}+",
                                                      style: textTheme
                                                          .titleMedium
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
                                style: textTheme.titleMedium
                                    ?.copyWith(fontSize: 19.sp),
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
                                  initialCameraPosition: CameraPosition(
                                    target: destinationData.cords!,
                                    zoom: 11.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                "Reviews (99)",
                                style: textTheme.titleMedium
                                    ?.copyWith(fontSize: 19.sp),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              FutureBuilder(
                                  future: homePageController.getReviews(
                                      destinationData!.destinationId!),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot2) {
                                    if (snapshot2.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: LoadingAnimationWidget
                                              .threeArchedCircle(
                                                  color: AppColors
                                                      .secondaryColor
                                                      .withOpacity(0.5),
                                                  size: 30.h));
                                    } else if (snapshot2.hasError) {
                                      return Center(
                                        child: Text("An error occured,",
                                            style: textTheme.bodySmall),
                                      );
                                    } else {
                                      final reviewData = snapshot2.data;
                                      return Column(
                                        children: List.generate(
                                            10,
                                            (index) => Review(
                                                  reviewModel: ReviewModel(
                                                      name: reviewData[0]?.name,
                                                      imageUrl: reviewData[0]
                                                          ?.imageUrl,
                                                      date: reviewData[1]?.date,
                                                      starCount: reviewData[0]
                                                          ?.starCount,
                                                      review: reviewData[0]
                                                          ?.review),
                                                )),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.horizontalPadding),
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
                                    color: AppColors.likeColor,
                                    fontSize: 21.sp),
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
                              Get.to(const Bookingdetails(), arguments: {
                                "destinationId": destinationData?.destinationId
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child:
                                  Text("Booking", style: textTheme.titleSmall),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
            }));
  }
}





// AIzaSyCJBO0XfD0AvZXpo_0UVTr2oBE1pL10TGk