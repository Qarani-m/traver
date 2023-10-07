import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const TopBar(
                text: "Payment Method",
              ),
              SizedBox(height: 30.h,),
              Method(text: "Google pay", image: AppImageStrings.google,),
              Method(text: "Mpesa", image: AppImageStrings.google,),
              PaymentNext(nextPage: SuccessPayment())
            
          ]),
      ),
    );
  }
}

