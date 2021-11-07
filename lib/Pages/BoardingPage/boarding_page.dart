import 'package:flutter/material.dart';
import 'package:mews/Values/dimens.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Values/images.dart';
import 'package:mews/Widgets/custom_text.dart';
import 'package:mews/Widgets/dock_button.dart';

class BoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              AppImage.imgBoarding,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Positioned(
                top: 100,
                left: 25,
                child: CustomText(
                  "GET OUR",
                  fontSize: FontSize.BIG_1,
                  color: Colors.black,
                )),
            Positioned(
                top: 140,
                left: 25,
                child: CustomText(
                  "BRAIN UPDATED",
                  fontSize: FontSize.BIG_2,
                  color: Colors.black,
                )),
            Positioned(
              bottom: 150,
              left: 25,
              child: CustomText(
                "The best simple place where you\n discover most updated and trusted news\n and make your knowledge horizoning",
                fontSize: FontSize.BIG,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.horizontalSpacing,
                ),
                child: DockButton(
                  name: "GET START",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
