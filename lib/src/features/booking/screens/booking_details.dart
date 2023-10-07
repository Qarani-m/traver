import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/widgets/text_field.dart';
import 'package:traver/src/features/booking/screens/payment_method.dart';
import 'package:traver/src/features/booking/widgets/payment_next.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';

class Bookingdetails extends StatelessWidget {
  const Bookingdetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = "Martin Karani";
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
                    controller: controller,
                    label: "Person Responsible",
                    hint: "",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFielAuth(
                    obscureText: false,
                    controller: controller,
                    label: "Phone Number",
                    hint: "",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFielAuth(
                    obscureText: false,
                    controller: controller,
                    label: "Email Address",
                    hint: "",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFielAuth(
                    obscureText: false,
                    controller: controller,
                    label: "Booked dates",
                    hint: "",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFielAuth(
                    obscureText: false,
                    controller: controller,
                    label: "ID number",
                    hint: "",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFielAuth(
                    obscureText: false,
                    controller: controller,
                    label: "Number of Members",
                    hint: "",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFielAuth(
                    obscureText: false,
                    controller: controller,
                    label: "Number of children",
                    hint: "",
                  ),
                  Text(
                    "* A child is anyone less than 11 years in age",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 13.sp, color: AppColors.likeColor),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFielAuth(
                    obscureText: false,
                    controller: controller,
                    label: "PWD",
                    hint: "",
                  ),
                ],
              ),
              SizedBox(
                height: 70.h,
              ),
             const PaymentNext(nextPage: PaymentMethod(),)
            ],
          ),
        ),
      ),
    );
  }
}
