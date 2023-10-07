import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';

class CustomerCare extends StatelessWidget {
  const CustomerCare({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    var brightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
                   padding:  EdgeInsets.only(left: 60.w),

          child: Text(
            "Customer Care",
            style: textTheme.bodyMedium,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.horizontalPadding),
            child: IconTheme(data: iconTheme, child: const Icon(Icons.call)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: AppSizes.horizontalPadding,
          right: AppSizes.horizontalPadding,
          // top: 50.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // TopBar(text: "Customer Care"),
              SizedBox(
                height: 2.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 650.h,
                    width: 390.w,
                    // color: Colors.blue,
                    child: const SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SenderText(text: "Hello there"),
                          RecvText(text: "hey, whats up"),
                          SenderText(text: "just dong some tests"),
                          RecvText(text: "Have some fun"),
                          SenderText(text: "cool"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                    width: 390.w,
                    // color: Colors.red,
                    child: SizedBox(
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
                      hintText: "Message",
                      hintStyle: textTheme.bodySmall),
                )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SenderText extends StatelessWidget {
  const SenderText({
    super.key,
    required this.text
  });
  final String text;

  @override
  Widget build(BuildContext context) {
     var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 5.h, top: 5.h, left: 40.h),
      child: Container(
        width: 390.w,
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.accentColor),
              borderRadius: BorderRadius.circular(10.r)),
          child: Text(text,style: textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}

class RecvText extends StatelessWidget {
  const RecvText({
    super.key,
    required this.text
  });
  final String text;

  @override
  Widget build(BuildContext context) {
     var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 5.h, top: 5.h, right: 40.h),
      child: Container(
        width: 390.w,
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.fadedTextColor),
              borderRadius: BorderRadius.circular(10.r)),
          child: Text(text, style: textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
