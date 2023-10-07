import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/features/home/screens/about_place.dart';

class FavouritePlace extends StatelessWidget {
  const FavouritePlace({
    super.key,
    required this.brightness,
  });

  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    return GestureDetector(
      onTap: () => Get.to(AboutPlace()),
      child: SizedBox(
        height: 260.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 260.h,
                      width: 185.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          image: DecorationImage(
                              image:
                                  AssetImage(AppImageStrings.onboarding[index]),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.h),
                      height: 260.h,
                      width: 185.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                AppColors.darkColor.withOpacity(0.5),
                                Colors.transparent
                              ])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                                backgroundColor: brightness == Brightness.dark
                                    ? AppColors.darkColor
                                    : Colors.white,
                                child: Icon(
                                  Icons.favorite,
                                  color: AppColors.likeColor,
                                )),
                          ),
                          Column(
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
                                SizedBox(
                                  height: 15.h,
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
                                  height: 10.h,
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
                              ])
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 60.h,
                  width: 15.w,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
