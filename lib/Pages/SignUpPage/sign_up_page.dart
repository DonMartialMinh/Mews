import 'package:flutter/material.dart';
import 'package:mews/Pages/SignUpPage/sign_up_form.dart';
import 'package:mews/Values/dimens.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Widgets/custom_text.dart';
import 'package:mews/Widgets/tap_outside_to_unfocus.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TapOutsideToUnfocus(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimen.verticalSpacing),
                SizedBox(
                  height: 65.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimen.spacing_3),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: const [
                        Divider(
                          color: Colors.black,
                          height: 1,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppDimen.spacing_3),
                  child: CustomText(
                    "Welcome",
                    fontSize: FontSize.BIG_2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
