import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
  const TopBar(
      {super.key,
      required this.text,
      this.widget = const SizedBox(
        width: 20,
      )});
  final String text;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: () => Get.back(),
        child: IconTheme(
          data: iconTheme,
          child: const Icon(Icons.arrow_back),
        ),
      ),
      Text(
        text,
        style: textTheme.bodyMedium,
      ),
      widget
    ]);
  }
}
