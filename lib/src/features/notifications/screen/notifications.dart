import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';
import 'package:traver/src/features/notifications/controller/notification_controller.dart';

class Notifications extends StatelessWidget {
   Notifications({super.key});
  //  NotificationsController notificationsController = Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            top: 50.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(text: "Notifications"),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Today",
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 21.sp),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                // onTap: ()=> notificationsController.fcm(),
                child: OneNotification(textTheme: textTheme)),
              OneNotification(textTheme: textTheme),
              OneNotification(textTheme: textTheme),
              OneNotification(textTheme: textTheme)
            ],
          ),
        ),
      ),
    );
  }
}

class OneNotification extends StatelessWidget {
  const OneNotification({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.h,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: AppColors.secondaryColor.withOpacity(0.3),
          child: Center(
              child: IconTheme(
                  data: Theme.of(context).iconTheme, child: Icon(Icons.book))),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Booking Success",
              style: textTheme.bodyMedium
                  ?.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: 265.w,
              child: Text(
                overflow: TextOverflow.ellipsis,
                "You have successfully booked  aslot for theenenne",
                style: textTheme.bodySmall,
              ),
            ),

          
          ],
        )
      ]),
    );
  }
}
