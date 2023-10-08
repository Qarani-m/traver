import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';
import 'package:traver/src/features/profile/controller/profile_controller.dart';
import 'package:traver/src/features/profile/models/faqs.dart';

class Faqs extends StatelessWidget {
   Faqs({super.key});
  ProfileController profileController = Get.find<ProfileController>();


  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

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
      body:Obx(
        () {
          if (profileController.faqsList.isEmpty) {
            return Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: AppColors.secondaryColor, size: 40.h),
                      );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: AppSizes.horizontalPadding,
                right: AppSizes.horizontalPadding,
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      
                    children: List.generate(profileController.faqsList.length, (index) =>QandA(model: profileController.faqsList[index], index: index,))
                  ),

                  ElevatedButton(onPressed:()=>profileController.loadFaqs() , child: Text("kjsksju"))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class QandA extends StatelessWidget {
  const QandA({super.key, required this.model, required this.index});

  final FaqsModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${index.toString()}: ${model.question}"),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: SizedBox(
              width: 310.w,
              child: Opacity(
                opacity: 0.5,
                child: Text(
                  model.answer??"-",
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
