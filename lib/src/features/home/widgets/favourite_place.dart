import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';
import 'package:traver/src/features/home/models/destination_model.dart';
import 'package:traver/src/features/home/screens/about_place.dart';

class FavouritePlace extends StatelessWidget {
  FavouritePlace({super.key, required this.destinationModel});
  final DestinationModel destinationModel;

HomePageController homePageController = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;

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
                    CachedNetworkImage(
                      imageUrl: destinationModel
                          .imageUrl!, // Replace with your network image URL
                      imageBuilder: (context, imageProvider) => Container(
                        height: 260.h,
                        width: 185.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Padding(
                        padding: EdgeInsets.only(left: 185.w / 2 ),
                        child: Center(
                            child: SizedBox(
                          height: 50.h,
                          width: 50.h,
                          child: LoadingAnimationWidget.threeArchedCircle(
                              color: AppColors.secondaryColor.withOpacity(0.5),
                              size: 30.h),
                        )),
                      ), // Placeholder for loading
                      errorWidget: (context, url, error) => Padding(
                        padding: EdgeInsets.only(left: 185.w / 2 - 20),
                        child: Center(child: Icon(Icons.error)),
                      ), // Placeholder for errors
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
                      child: Obx(()=> Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: ()=>homePageController.toggleLike(index.toString()),
                                child: CircleAvatar(
                                    backgroundColor: brightness == Brightness.dark
                                        ? AppColors.darkColor
                                        : Colors.white,
                                    child: Icon(
                                        homePageController.likedDestinations.contains(index)?Icons.favorite:Icons.favorite_outline,
                                        color: AppColors.likeColor,
                                      ),
                                    ),
                              ),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.h),
                                    child: Text(destinationModel.name!,
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
                                        "${destinationModel.location!.split(" ")[0]}, ${homePageController.likedDestinations}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 5.h,
                                      ),
                                      Text(
                                          destinationModel.location!
                                              .split(" ")[1],
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
                                          initialRating: double.parse(
                                              destinationModel.starCount!),
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
                                          destinationModel.starCount!,
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
