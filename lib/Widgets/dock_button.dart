import 'package:flutter/material.dart';
import 'package:mews/values/colors.dart';
import 'package:mews/values/font_sizes.dart';

class DockButton extends StatelessWidget {
  final String name;

  DockButton({required this.name});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0);
    final buttonWidth = MediaQuery.of(context).size.width - 32.0;
    return Container(
      width: buttonWidth,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: borderRadius, color: AppColor.colorPrimary),
      child: Center(
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: FontSize.MEDIUM),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
