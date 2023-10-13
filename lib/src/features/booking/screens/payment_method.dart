import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/booking/screens/booking_details.dart';
import 'package:traver/src/features/booking/screens/succes_payment.dart';
import 'package:traver/src/features/booking/widgets/payment_methos.dart';
import 'package:traver/src/features/booking/widgets/payment_next.dart';
import 'package:traver/src/features/home/models/booking_model.dart';
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
                                  color: AppColors
                                      .secondaryColor)), // Add a border
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the AlertDialog
                        },
                        child: Text('Close', style: textTheme.bodySmall),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.secondaryColor,
                        ),
                        onPressed: () async {
                          setState(() {
                            paymentProcessing = true;
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await bookDestination(prefs.getString("email") ?? "", "12");
                          await lipaNaMpesa();

                          await Future.delayed(Duration(seconds: 5));
                          Get.off(SuccessPayment());
                        },
                        child: Text(
                          'Confirm',
                          style: textTheme.bodySmall,
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> bookDestination(String userId, String destinationId) async {
    try {
      QuerySnapshot userQuerySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userId)
          .get();

     if (userQuerySnapshot.docs.isNotEmpty) {
  BookingModel bookingModel = BookingModel(
    personResponsible: "Martin",
    phoneNumber: "0704847676",
    emailAddress: "Emqarani",
    dates: "dates",
    idNumber: "782399839",
    numberOfChildren: "0",
    numberOfMembers: "2",
    pwdNumber: "0"
  );

  // Convert the BookingModel to a Map using the toJson method
  Map<String, dynamic> bookingData = bookingModel.toJson();

  // Update the Firestore document to add the new BookingModel to the "booked" array
  await userQuerySnapshot.docs.first.reference.update({
    'booked': FieldValue.arrayUnion([bookingData])
  });
}
    } catch (e) {
      print('Error booking destination: $e');
    }
  }

  Future<void> lipaNaMpesa() async {
    dynamic transactionInitialisation;
    try {
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: 1.0,
          partyA: "254768785886",
          partyB: "174379",
          callBackURL: Uri(
              scheme: "https",
              host: "mpesa-requestbin.herokuapp.com",
              path: "/1hhy6391"),
          accountReference: "Traver tours",
          phoneNumber: "254768785886",
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purchase",
          passKey:
              "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
      print("TRANSACTION RESULT: " + transactionInitialisation.toString());
      return transactionInitialisation;
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
    }
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
              child: Text('Close', style: textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}
