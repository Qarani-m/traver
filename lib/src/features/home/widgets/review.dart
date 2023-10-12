import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/features/home/models/review_model.dart';

class Review extends StatelessWidget {
  Review({
    required this.reviewModel,
    super.key,
  });

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 390.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60.h,
            width: 60.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                      AppImageStrings.onboarding[2],
                    ),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 260.w,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        reviewModel.name!,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp),
                      ),
                      Text(reviewModel.date!, style: textTheme.bodySmall)
                    ]),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: List.generate(
                    int.parse(reviewModel.starCount!),
                    (index) => Icon(
                          Icons.star,
                          color: AppColors.secondaryColor,
                          size: 20.h,
                        )),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 260.w,
                child: Text(
                  reviewModel.review!,
                  style: textTheme.bodySmall?.copyWith(height: 1.7),
                ),
              ),
              SizedBox(height: 20.h)
            ],
          ),
        ],
      ),
    );
  }
}
