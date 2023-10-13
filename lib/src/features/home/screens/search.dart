import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';
import 'package:traver/src/features/home/controller/searc_controller.dart';
import 'package:traver/src/features/home/models/destination_model.dart';
import 'package:traver/src/features/home/screens/filter.dart';
import 'package:traver/src/features/home/widgets/popular_packages.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';

class Search extends StatelessWidget {
  Search({super.key});

  SearchPageController searchPageController = Get.find<SearchPageController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var brightness = MediaQuery.of(context).platformBrightness;
    var iconTheme = Theme.of(context).iconTheme;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSizes.horizontalPadding,
          right: AppSizes.horizontalPadding,
          top: 60.h,
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(
                text: "Search",
                // widget: GestureDetector(
                //     onTap: () => Get.to(const FilterSearch()),
                //     child: IconTheme(
                //         data: iconTheme, child: const Icon(Icons.tune))),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                  height: 60.h,
                  width: 390.w,
                  child: TextField(
                    onEditingComplete: () {
                      searchPageController.onEditingComplete();
                    },
                    controller: searchPageController.searchPageController,
                    onChanged: (val) => searchPageController.beginSearch(val),
                    style: textTheme.bodySmall?.copyWith(fontSize: 17.sp),
                    autofocus: true,
                    cursorColor: brightness == Brightness.dark
                        ? AppColors.fadedTextColor
                        : AppColors.darkColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 23.w, top: 15.h, bottom: 15.h),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: brightness == Brightness.dark
                                  ? AppColors.fadedTextColor.withOpacity(0.1)
                                  : AppColors
                                      .fadedTextColor), // Set the border color when focused
                          borderRadius: BorderRadius.circular(
                              20.r), // Set the border radius
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: brightness == Brightness.dark
                                  ? AppColors.fadedTextColor.withOpacity(0.1)
                                  : AppColors
                                      .fadedTextColor), // Set the border color when not focused
                          borderRadius: BorderRadius.circular(
                              15.h), // Set the border radius
                        ),
                        hintMaxLines: 1,
                        hintText: "Search destination",
                        hintStyle: textTheme.bodySmall),
                  )),
              SizedBox(
                height: 20.h,
              ),
              !searchPageController.showRecentSearches.value
                  ? Container()
                  : FutureBuilder(
                      future: searchPageController.getRecentSerches(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else {
                          return Column(
                            children: List.generate(
                                searchPageController.searchList.length,
                                (index) => Padding(
                                      padding: EdgeInsets.only(top: 20.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                IconTheme(
                                                    data: iconTheme,
                                                    child:
                                                        Icon(Icons.schedule)),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(
                                                  searchPageController
                                                      .searchList[index],
                                                  //  snapshot.data[index],
                                                  style: textTheme.bodySmall,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                          );
                        }
                      }),
              SizedBox(
                height: 30.h,
              ),
              searchPageController.showRecentSearches.value
                  ? Container()
                  : Text(
                      "We found ${searchPageController.dmodels.length} trips for '${searchPageController.searchPageController.text}'",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                        
                    ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                children: List.generate(
                    searchPageController.dmodels.length,
                    (index) => PopularPackage(
                        destinationModel: DestinationModel(
                            destinationId:searchPageController.dmodels[index].destinationId,
                            price: searchPageController.dmodels[index].price,
                            mantra: searchPageController.dmodels[index].mantra,
                            imageUrl:searchPageController.dmodels[index].imageUrl,
                            starCount:searchPageController.dmodels[index].starCount,
                            location:
                                searchPageController.dmodels[index].location,
                            name: searchPageController.dmodels[index].name))),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
