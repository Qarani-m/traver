import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traver/src/constants/colors.dart';

class Method extends StatelessWidget {
  const Method({
    super.key,
    required this.text,
    required this.image,
  });
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 20.h),
      child: Container(
        padding: EdgeInsets.only(left: 15.w),
        height: 70.h,
        width:  390.w,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.fadedTextColor)
        ),
        child: Row(
          children: [
            Image(image: AssetImage(image), height: 30.h, width: 30.h,),
            SizedBox(height: 1, width: 15.w,),
            Text(text, style: Theme.of(context).textTheme.bodySmall,)
          ],
        ),
      ),
    );
  }
}