import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/booking/screens/booking_details.dart';
import 'package:traver/src/features/booking/screens/succes_payment.dart';
import 'package:traver/src/features/booking/widgets/payment_methos.dart';
import 'package:traver/src/features/booking/widgets/payment_next.dart';
import 'package:traver/src/features/home/widgets/topnavbar.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: AppSizes.horizontalPadding,
          right: AppSizes.horizontalPadding,
          top: 50.h,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const TopBar(
            text: "Payment Method",
          ),
          SizedBox(
            height: 30.h,
          ),
          // Method(
          //   text: "Google pay",
          //   image: AppImageStrings.google,
          // ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSizedAlertDialog(); // Custom AlertDialog
                },
              );
            },
            child: Method(
              text: "Mpesa",
              image: AppImageStrings.google,
            ),
          ),
          // Method(
          //   text: "Debit card",
          //   image: AppImageStrings.google,
          // ),
          SizedBox(
            height: 360.h,
          ),

          TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorDialog(); // Custom AlertDialog
                  },
                );
              },
              child: Text("error in payment"))

          // PaymentNext(nextPage: SuccessPayment())
        ]),
      ),
    );
  }
}

class CustomSizedAlertDialog extends StatefulWidget {
  const CustomSizedAlertDialog({super.key});
  @override
  State<CustomSizedAlertDialog> createState() => _CustomSizedAlertDialogState();
}

class _CustomSizedAlertDialogState extends State<CustomSizedAlertDialog> {
  var paymentProcessing = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var brightness = MediaQuery.of(context).platformBrightness;

    return AlertDialog(
      backgroundColor:
          brightness == Brightness.dark ? AppColors.darkColor : Colors.white,
      contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w, vertical: 30.h), // Adjust the padding as needed
      content: Container(
        width: 340.w, // Set the desired width
        height: !paymentProcessing ? 200.h : 131.h, // Set the desired height
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            !paymentProcessing
                ? Text("Confirm Payment of 21900 from 0704847676",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 17.sp))
                : Text("Please wait while we process your payment",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 17.sp)),
            SizedBox(height: 20.h),
            paymentProcessing
                ? Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                        color: AppColors.secondaryColor, size: 40.h),
                  )
                : Container(),
            !paymentProcessing
                ? Text(
                    textAlign: TextAlign.center,
                    'To change number go to \nprofile > personal information > phone number > Update profile',
                    style: textTheme.bodySmall,
                  )
                : Container(),
            SizedBox(height: 20.h),
            !paymentProcessing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              Colors.transparent), // Remove background color
                          side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(
                                  width: 1.0,
                                  color:AppColors.secondaryColor)), // Add a border
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the AlertDialog
                        },
                        child:  Text('Close',style: textTheme.bodySmall),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.secondaryColor,
                        ),
                        onPressed: () async {
                          setState(() {
                            paymentProcessing = true;
                          });
                          await Future.delayed(Duration(seconds: 5));
                          Get.off(SuccessPayment());
                        },
                        child:  Text('Confirm', style: textTheme.bodySmall,),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class ErrorDialog extends StatefulWidget {
  const ErrorDialog({super.key});
  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  var paymentProcessing = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var brightness = MediaQuery.of(context).platformBrightness;

    return AlertDialog(
      backgroundColor:
          brightness == Brightness.dark ? AppColors.darkColor : Colors.white,
      contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w, vertical: 30.h), // Adjust the padding as needed
      content: Container(
        width: 340.w, // Set the desired width
        height: !paymentProcessing ? 118.h : 131.h, // Set the desired height
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("An error occured, we could not process your payment",
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.likeColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 17.sp)),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.secondaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the AlertDialog
              },
              child:  Text('Close',style: textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}
