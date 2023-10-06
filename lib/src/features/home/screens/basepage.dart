import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController());
    var _selectedColor =MediaQuery.of(context).platformBrightness ==Brightness.dark?AppColors.fadedTextColor:AppColors.darkColor;
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: homePageController.currentPageIndex.value,
        onTap: (index) {
          setState(() {
            homePageController.currentPageIndex.value = index;
          });
        },
        selectedItemColor: AppColors.accentColor,
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              AppImageStrings.nabarIcons[0],
              color: _selectedColor,
              height: 25.h,
            ),
            title: Text(
              "Home",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            selectedColor: _selectedColor,
          ),
          SalomonBottomBarItem(
            icon: SvgPicture.asset(AppImageStrings.nabarIcons[1],
                color: _selectedColor, height: 25.h),
            title: Text(
              "Trips",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            selectedColor: _selectedColor,
          ),
          SalomonBottomBarItem(
            icon: SvgPicture.asset(AppImageStrings.nabarIcons[2],
                color: _selectedColor, height: 25.h),
            title: Text(
              "Wishlist",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            selectedColor: _selectedColor,
          ),
          SalomonBottomBarItem(
            icon: SvgPicture.asset(AppImageStrings.nabarIcons[3],
                color: _selectedColor, height: 25.h),
            title: Text(
              "profile",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            selectedColor: _selectedColor,
          ),
        ],
      ),
      body: Obx(() =>
          homePageController.pages[homePageController.currentPageIndex.value]),
    );
  }
}
