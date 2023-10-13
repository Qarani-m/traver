import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/profile/controller/profile_controller.dart';

class CustomerCare extends StatelessWidget {
  CustomerCare({super.key});
  ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    var brightness = MediaQuery.of(context).platformBrightness;
    var _selectedColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? AppColors.fadedTextColor
            : AppColors.darkColor;



            

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 60.w),
          child: Text(
            "Customer Care",
            style: textTheme.bodyMedium,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.horizontalPadding),
            child: GestureDetector(
                onTap: () => profileController.callCC(),
                child:
                    IconTheme(data: iconTheme, child: const Icon(Icons.call))),
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: profileController.messageStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                              return   Text("An error occured",
                                    style: textTheme.bodySmall
                                        ?.copyWith(color: AppColors.likeColor));
                              }

                              else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: EdgeInsets.all(10.h),
                                  child: Center(
                                    child: LoadingAnimationWidget
                                        .threeArchedCircle(
                                            color: AppColors.secondaryColor,
                                            size: 40.h),
                                  ),
                                );
                              }else{
                              return Column(
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return data['isFromAdmin']
                                    ? data['senderEmail'] == profileController.prefsList[1]?RecvText(
                                        text: data['message'].toString(),
                                        time: DateFormat('HH:mm').format(data[
                                                'time']
                                            .toDate())) :const SizedBox()
                                    : data['senderEmail'] == profileController.prefsList[1]?SenderText(
                                        text: data['message'].toString(),
                                        time: DateFormat('HH:mm')
                                            .format(data['time'].toDate())):const SizedBox();
                              }).toList());}
                            },
                          )
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
                          onEditingComplete: ()=>profileController.sendText(),
                          controller: profileController.messageController,
                          onChanged: (val) => profileController
                              .messageLength.value = val.length,
                          style: textTheme.bodySmall?.copyWith(fontSize: 17.sp),
                          cursorColor: brightness == Brightness.dark
                              ? AppColors.fadedTextColor
                              : AppColors.darkColor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 23.w,
                                top: 15.h,
                                bottom: 15.h,
                                right: 10.w),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: brightness == Brightness.dark
                                      ? AppColors.fadedTextColor
                                          .withOpacity(0.1)
                                      : AppColors
                                          .fadedTextColor), // Set the border color when focused
                              borderRadius: BorderRadius.circular(
                                  20.r), // Set the border radius
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: brightness == Brightness.dark
                                      ? AppColors.fadedTextColor
                                          .withOpacity(0.1)
                                      : AppColors
                                          .fadedTextColor), // Set the border color when not focused
                              borderRadius: BorderRadius.circular(
                                  15.h), // Set the border radius
                            ),
                            hintMaxLines: 1,
                            hintText: "Message",
                            hintStyle: textTheme.bodySmall,
                            suffixIcon: Transform.rotate(
                              angle: 45 * (3.1415926535 / 180),
                              child: Obx(
                                () => profileController.messageLength > 0
                                    ? GestureDetector(
                                        onTap: () =>
                                            profileController.sendText(),
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.w),
                                          child: SvgPicture.asset(
                                            AppImageStrings.nabarIcons[1],
                                            color: _selectedColor,
                                            height: 25.h,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                          ),
                        )),
                  )
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
  const SenderText({super.key, required this.text, required this.time});
  final String text;
  final String time;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 5.h, top: 5.h, left: 40.h),
      child: Container(
        // : 390.w,
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.accentColor),
              borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                text,
                style: textTheme.bodySmall,
              ),
              SizedBox(
                height: 5.h,
              ),
              Opacity(
                opacity: 0.5,
                child: Text(
                  time,
                  style: textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecvText extends StatelessWidget {
  const RecvText({super.key, required this.text, required this.time});
  final String text;
  final String time;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                text,
                style: textTheme.bodySmall,
              ),
              SizedBox(height: 5.h),
              Opacity(
                opacity: 0.5,
                child: Text(
                  time,
                  style: textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
