import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mews/Values/images.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Column(
        children: List.generate(
            errors.length, (index) => formErrorText(error: errors[index]!)),
      ),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        SvgPicture.asset(AppImage.icError),
        const SizedBox(
          width: 10,
        ),
        Text(error),
      ],
    );
  }
}
