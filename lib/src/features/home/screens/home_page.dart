import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/controllers/auth_controller.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';
import 'package:traver/src/features/home/models/destination_model.dart';
import 'package:traver/src/features/home/screens/category.dart';
import 'package:traver/src/features/notifications/screen/notifications.dart';
import 'package:traver/src/features/home/screens/search.dart';
import 'package:traver/src/features/home/widgets/favourite_place.dart';
import 'package:traver/src/features/home/widgets/popular_packages.dart';
import 'package:traver/src/features/home/widgets/right_left.dart';
import 'package:traver/src/features/profile/controller/profile_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();
    HomePageController homePageController = Get.find<HomePageController>();

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
      child: Obx(
        () => Padding(
          padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            top: 60.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: profileController.profilePicImageUrl.value
                                .startsWith("https")
                            ? ClipOval(
                                child: CachedNetworkImage(
                                    imageUrl: profileController
                                        .profilePicImageUrl.value,
                                    placeholder: (context, url) => Container(
                                          height: 40.h,
                                          width: 40.h,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.fadedTextColor
                                                  .withOpacity(0.1)),
                                          child: Center(
                                              child: profileController
                                                      .prefsList.isNotEmpty
                                                  ? Text(
                                                      "${profileController.prefsList[0].split(" ")[0][0]}.${profileController.prefsList[0].split(" ")[1][0]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    )
                                                  : Container()),
                                        ),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          height: 40.h,
                                          width: 40.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          height: 40.h,
                                          width: 40.h,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.fadedTextColor
                                                  .withOpacity(0.1)),
                                          child: Center(
                                              child: profileController
                                                      .prefsList.isNotEmpty
                                                  ? Text(
                                                      "${profileController.prefsList[0].split(" ")[0][0]}.${profileController.prefsList[0].split(" ")[1][0]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    )
                                                  : Container()),
                                        )))
                            : Center(
                                child: profileController.prefsList.isNotEmpty
                                    ? Text(
                                        "${profileController.prefsList[0].split(" ")[0][0]}.${profileController.prefsList[0].split(" ")[1][0]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      )
                                    : Container()),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Hello, ${homePageController.name.value.split(' ')[0].toLowerCase()}!",
                        style: textTheme.titleSmall?.copyWith(
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                          child: GestureDetector(
                        onTap: () => Get.to(Notifications()),
                        child: IconTheme(
                            data: iconTheme,
                            child: Icon(
                              Icons.notifications_outlined,
                              size: 30.h,
                              weight: 0.1,
                            )),
                      )),
                      Positioned(
                          top: 2.h,
                          right: 2.h,
                          child: CircleAvatar(
                            radius: 5.r,
                            backgroundColor: AppColors.likeColor,
                          ))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Where do you\nwant to explore today",
                style: textTheme.titleMedium,
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to( Search());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  height: 50.h,
                  width: 390.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Search destination",
                        style: textTheme.bodyLarge,
                      ),
                      IconTheme(
                          data: iconTheme,
                          child: Icon(
                            Icons.search,
                            size: 35.h,
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                  onTap: () => Get.to(const Categorys()),
                  child: const RightLeft(
                      left: "Choose Category", right: "See all")),
              SizedBox(
                height: 10.h,
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
              SizedBox(
                height: 20.h,
              ),
              const RightLeft(left: "Favourite Places", right: "Explore"),
              SizedBox(
                height: 20.h,
              ),
              FutureBuilder(
                  future: homePageController.getFavouritePlacesPrefs(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center();
                    } else if (snapshot.hasError) {
                      return SizedBox(
                        height: 260.h,
                        width: 390.w,
                        child: Center(
                            child: Text(
                          "An Error occured, try relaunching the app",
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                      );
                    } else {
                      final snapData = snapshot.data;
                      return SizedBox(
                          height: 260.h,
                          child: ListView.builder(
                            itemCount: snapData.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return FavouritePlace(
                                  destinationModel: DestinationModel(
                                name: snapData[index].name,
                                destinationId: snapData[index].destinationId,
                                imageUrl: snapData[index].imageUrl,
                                starCount: snapData[index].starCount,
                                price: snapData[index].price,
                                location: snapData[index].location,
                              ));
                            },
                          ));
                    }
                  }),
              SizedBox(
                height: 20.h,
              ),
              const RightLeft(left: "Popular Packages", right: "See All"),
              SizedBox(
                height: 20.h,
              ),
              Column(
                children: List.generate(
                    5,
                    (index) => PopularPackage(
                        destinationModel: DestinationModel(
                            destinationId: "${index}ilk",
                            imageUrl:
                                "https://firebasestorage.googleapis.com/v0/b/traver-79d4b.appspot.com/o/destinations%2Fpexels-photo-5372613.jpeg?alt=media&token=65c42c57-6705-4ed2-92a4-5f087c010630&_gl=1*gthss5*_ga*OTU2MDYyODE5LjE2OTYzNTE3MTQ.*_ga_CW55HF8NVT*MTY5Njg0MzI2MC4yMy4xLjE2OTY4NDM0ODAuMzcuMC4w",
                            starCount: "3.8",
                            location: "Bali Indonesia",
                            name: "Kuta beach",
                            price: "21908",
                            mantra:
                                "A resort is a place used for relaxation, vacation and as a destination for all that are willing"))),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class test extends StatelessWidget {
  const test({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    AuthController authController = Get.put(AuthController());
    HomePageController homePageController = Get.put(HomePageController());
    return Padding(
      padding: EdgeInsets.only(
          left: AppSizes.horizontalPadding,
          right: AppSizes.horizontalPadding,
          top: 60.h),
      child: Obx(
        () => Column(
          children: [
            Text(
              "Name: ${homePageController.name.value}",
              style: textTheme.bodySmall,
            ),
            Text(
              "Email: ${homePageController.email.value}",
              style: textTheme.bodySmall,
            ),
            Text(
              "Phone: ${homePageController.phone.value}",
              style: textTheme.bodySmall,
            ),
            SizedBox(
              child: Row(
                children: [
                  Text(
                    "Itrests: ",
                    style: textTheme.bodySmall,
                  ),
                  Row(
                    children: List.generate(homePageController.intrests.length,
                        (index) {
                      return Text(
                        " ${homePageController.intrests[index]} , ",
                        style: textTheme.bodySmall,
                      );
                    }),
                  )
                ],
              ),
            ),

            // Text("Intrests: ${}"),
            Center(
              child: TextButton(
                onPressed: () async {
                  authController.signoutUser();
                },
                child: const Text("Log out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
