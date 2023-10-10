import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';
import 'package:traver/src/features/home/models/destination_model.dart';

class PopularPackage extends StatelessWidget {
   PopularPackage({
    super.key,
    required this.destinationModel, 
  });

  final DestinationModel destinationModel;

  HomePageController homePageController = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;

    return Obx(()=>Column(
        children: [
          GestureDetector(
            onTap: ()=>homePageController.placeDetails(destinationModel.destinationId!),
            child: SizedBox(
              height: 142.h,
              width: 380.w,
              child: Row(
                children: [
                 CachedNetworkImage(
                        imageUrl: destinationModel
                            .imageUrl!, // Replace with your network image URL
                        imageBuilder: (context, imageProvider) => Container(
                          height: 260.h,
                          width: 105.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                            child: SizedBox(
                          height: 50.h,
                          width: 43.h,
                          child: LoadingAnimationWidget.threeArchedCircle(
                              color: AppColors.secondaryColor.withOpacity(0.5),
                              size: 30.h),
                        )), // Placeholder for loading
                        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)), // Placeholder for errors
                      ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 185.w,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                destinationModel.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              GestureDetector(
                                    onTap: () => homePageController
                                        .toggleLike(destinationModel.destinationId!),
                                    child: CircleAvatar(
                                      backgroundColor: brightness == Brightness.dark
                                          ? AppColors.darkColor
                                          : Colors.white,
                                      child: homePageController.likedDestinations.contains(destinationModel.destinationId.toString())?Icon(
                                        Icons.favorite,
                                        color: AppColors.likeColor,
                                      ): Icon(
                                        Icons.favorite_outline,
                                        color: AppColors.likeColor,
                                      ),
                                    ),
                                  )
                            ]),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Text(
                        "Ksh ${destinationModel.price}",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColors.likeColor),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              RatingBar.builder(
                                allowHalfRating:true,
                                unratedColor: AppColors.fadedTextColor,
                                initialRating:  double.parse(destinationModel.starCount!),
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemSize: 15.h,
                                onRatingUpdate: (rating) {},
                              ),
                              Positioned(
                                top: 0.h,
                                left: 0.h,
                                child: Container(
                                color: Colors.transparent,
                                height: 20.h,
                                width: 70.w,
                              ))
                            ],
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            destinationModel.starCount!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 13.sp),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      SizedBox(
                        width: 190.w,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          destinationModel.mantra!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 13.sp, height: 1.7),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h,)
        ],
      ),
    );
  }
}
