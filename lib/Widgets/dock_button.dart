import 'package:flutter/material.dart';
import 'package:mews/Widgets/custom_text.dart';
import 'package:mews/values/colors.dart';
import 'package:mews/values/font_sizes.dart';

typedef OnPressed();

class DockButton extends StatelessWidget {
  final String name;
  final OnPressed onPressed;

  DockButton({required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0);
    final buttonWidth = MediaQuery.of(context).size.width - 32.0;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: buttonWidth,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: borderRadius, color: AppColor.colorPrimary),
        child: Center(
          child: CustomText(
            name,
            color: Colors.white,
            fontSize: FontSize.MEDIUM,
            align: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
