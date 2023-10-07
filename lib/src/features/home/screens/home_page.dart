import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/controllers/auth_controller.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';
import 'package:traver/src/features/home/screens/category.dart';
import 'package:traver/src/features/home/screens/notifications.dart';
import 'package:traver/src/features/home/screens/search.dart';
import 'package:traver/src/features/home/widgets/favourite_place.dart';
import 'package:traver/src/features/home/widgets/popular_packages.dart';
import 'package:traver/src/features/home/widgets/right_left.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController());

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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(AppImageStrings.onboarding[2]),
                              fit: BoxFit.cover),
                        ),
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
                onTap: (){Get.to(Search());},
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
                onTap: ()=> Get.to(Categorys()),
                child: RightLeft(left: "Choose Category", right: "See all")),
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
              FavouritePlace(brightness: brightness),
              SizedBox(
                height: 20.h,
              ),
              const RightLeft(left: "Popular Packages", right: "See All"),
              SizedBox(
                height: 20.h,
              ),
              Column(
                children: List.generate(5, (index) => PopularPackage()),
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
