import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';

class PaymentNext extends StatelessWidget {
  const PaymentNext({
    required this.nextPage,
    super.key,
  });
  final Widget nextPage;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var brightness = MediaQuery.of(context).platformBrightness;
    return SizedBox(
      // color: Colors.red,
      height: 60.h,
      width: 390.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Total",
                style: textTheme.bodySmall,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                "Ksh 21900",
                style: textTheme.titleSmall
                    ?.copyWith(color: AppColors.likeColor, fontSize: 21.sp),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.to(nextPage);
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.h,
              width: 150.w,
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Text("Payment Method", style: textTheme.titleSmall),
            ),
          )
        ],
      ),
    );
  }
}
