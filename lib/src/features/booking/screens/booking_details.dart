import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/widgets/text_field.dart';
import 'package:traver/src/features/booking/screens/payment_method.dart';
import 'package:traver/src/features/booking/widgets/payment_next.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';

class Bookingdetails extends StatelessWidget {
  const Bookingdetails({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    HomePageController homePageController = Get.find<HomePageController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
              left: AppSizes.horizontalPadding,
              right: AppSizes.horizontalPadding,
              top: 50.h,
            ),
            child: FutureBuilder(
                future: homePageController.booking(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: AppColors.secondaryColor.withOpacity(0.5),
                            size: 30.h));
                  } else if (snapshot.hasError) {
                    return Center(
                      child:
                          Text("An error occured,", style: textTheme.bodySmall),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TopBar(
                        text: "Booking Details",
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          TextFielAuth(
                            
                            obscureText: false,
                            controller:
                                homePageController.personResponsibleControlller,
                            label: "Person Responsible",
                            hint: "",
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFielAuth(
                            obscureText: false,
                            controller:
                                homePageController.phoneNumberController,
                            label: "Phone Number",
                            hint: "",
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFielAuth(
                            obscureText: false,
                            controller: homePageController.emailController,
                            label: "Email Address",
                            hint: "",
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFielAuth(
                            obscureText: false,
                            controller: homePageController.datesController,
                            label: "Booked dates",
                            hint: "",
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFielAuth(
                            obscureText: false,
                            controller: homePageController.idNumberController,
                            label: "ID number",
                            hint: "",
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFielAuth(
                            obscureText: false,
                            controller:
                                homePageController.numberOfMembersController,
                            label: "Number of Members",
                            hint: "",
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFielAuth(
                            obscureText: false,
                            controller:
                                homePageController.numberOfChildrenController,
                            label: "Number of children",
                            hint: "",
                          ),
                          Text(
                            "* A child is anyone less than 11 years in age",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 13.sp,
                                    color: AppColors.likeColor),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFielAuth(
                            obscureText: false,
                            controller: homePageController.pwdController,
                            label: "PWD",
                            hint: "",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                      const PaymentNext(
                        nextPage: PaymentMethod(),
                      )
                    ],
                  );
                })),
      ),
    );
  }
}
