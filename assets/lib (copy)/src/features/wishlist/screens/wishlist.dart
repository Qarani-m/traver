import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/home/models/destination_model.dart';
import 'package:traver/src/features/home/screens/about_place.dart';
import 'package:traver/src/features/home/widgets/popular_packages.dart';
import 'package:traver/src/features/wishlist/controller/wishlist_controller.dart';

class WishList extends StatelessWidget {
  WishList({super.key});
  WishListController wishListController = Get.find<WishListController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var brightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
        left: AppSizes.horizontalPadding,
        right: AppSizes.horizontalPadding,
        top: 50.h,
      ),
      child: Column(
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
                      borderRadius:
                          BorderRadius.circular(20.r), // Set the border radius
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: brightness == Brightness.dark
                              ? AppColors.fadedTextColor.withOpacity(0.1)
                              : AppColors
                                  .fadedTextColor), // Set the border color when not focused
                      borderRadius:
                          BorderRadius.circular(15.h), // Set the border radius
                    ),
                    hintMaxLines: 1,
                    hintText: "Search destination",
                    hintStyle: textTheme.bodySmall),
              )),
          SizedBox(
            height: 30.h,
          ),
          FutureBuilder(
              future: wishListController.getLiked(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                          color: AppColors.secondaryColor.withOpacity(0.5),
                          size: 30.h));
                } else if (snapshot.hasError) {
                  return Center(
                    child:
                        Text("An error occured,", style: textTheme.bodySmall),
                  );
                } else {
                  final snapData = snapshot.data;
                  print(snapData.runtimeType);
                  return Column(
                    children: List.generate(
                           snapData.length,
                        (index) => Favourite(
                              destinationModel: DestinationModel(
                                name: snapData[index].name,
                                destinationId: snapData[index].destinationId,
                                imageUrl: snapData[index].imageUrl,
                                starCount: snapData[index].starCount,
                                price: snapData[index].price,
                                location: snapData[index].location,
                                mantra: snapData[index].mantra,
                              ),
                            )),
                  );
                }
              }),
        ],
      ),
    ));
  }
}

class Favourite extends StatelessWidget {
  Favourite({super.key, required this.destinationModel});
  final DestinationModel destinationModel;
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopularPackage(
            destinationModel: DestinationModel(
                destinationId:destinationModel.destinationId,
                imageUrl: destinationModel.imageUrl,
                starCount: destinationModel.starCount,
                location: destinationModel.location,
                name: destinationModel.name,
                price: destinationModel.price,
                mantra:destinationModel.mantra,
                    ))
      ],
    );
  }
}
