import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';

class Faqs extends StatelessWidget {
  const Faqs({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    var brightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 100.w),
          child: Text(
            "Faqs",
            style: textTheme.bodyMedium,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20.h,
            ),
            QandA(textTheme: textTheme),
            QandA(textTheme: textTheme),
            QandA(textTheme: textTheme),
          ]),
        ),
      ),
    );
  }
}

class QandA extends StatelessWidget {
  const QandA({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("1: Let's Talk about refunds"),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: SizedBox(
              width: 310.w,
              child: Opacity(
                opacity: 0.5,
                child: Text(
                  "to give it a border and rounded corners.we display the character count to show the number of characters lines, and it will expand or contract based on the content.",
                  style: textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
