import 'package:flutter/material.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Widgets/app_bar.dart';
import 'package:mews/Widgets/custom_text.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
        leading: Container(),
        title: CustomText(
          'Trending',
          fontSize: FontSize.BIG,
        ));
  }

  Widget _buildBody() {
    return Container();
  }
}
