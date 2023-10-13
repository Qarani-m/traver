import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RightLeft extends StatelessWidget {
  const RightLeft({
    super.key,
    required this.left,
    required this.right,
  });

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 19.sp),
        ),
        Text(
          right,
          style:
              Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15.sp),
        )
      ],
    );
  }
}
