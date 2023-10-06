import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traver/src/constants/colors.dart';

class Question extends StatelessWidget {
  const Question({
    super.key,
    required this.question,
    this.forgotPassword = false,
  });
  final String question;
  final bool forgotPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(forgotPassword? 'Input your email': "Create your account",
            style: Theme.of(context).textTheme.titleSmall,),
        SizedBox(
          height: 15.h,
        ),
        Text(question,
            style: Theme.of(context).textTheme.titleMedium,)
      ],
    );
  }
}
