import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';

class PopularPackage extends StatelessWidget {
  const PopularPackage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150.h,
          width: 390.w,
          child: Row(
            children: [
              Container(
                height: 150.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage(AppImageStrings.onboarding[2]),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 190.w,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Kuta Resort",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          IconTheme(
                              data: Theme.of(context).iconTheme,
                              child: Icon(Icons.favorite_border_outlined))
                        ]),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    "Ksh 21900",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.likeColor),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        unratedColor: AppColors.fadedTextColor,
                        initialRating: 4.3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemSize: 15.h,
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
                            ?.copyWith(fontSize: 13.sp),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  SizedBox(
                    width: 190.w,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      "A resort is a place used for vacation, relaxation or as a day wasting facility",
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
        SizedBox(height: 20.h,)
      ],
    );
  }
}
