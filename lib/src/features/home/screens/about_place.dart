import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traver/src/constants/size.dart';

class AboutPlace extends StatelessWidget {
  const AboutPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            top: 60.h,

          ),
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}