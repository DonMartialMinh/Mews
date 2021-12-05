import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mews/Values/font_sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final PreferredSize? bottom;
  List<Widget>? actions = [];

  CustomAppBar({Key? key, this.leading, this.title, this.actions, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0.0,
      centerTitle: true,
      title: _buildTitle(),
      leading: leading,
      bottom:
          bottom ?? PreferredSize(preferredSize: Size.zero, child: Container()),
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  Widget _buildTitle() {
    return DefaultTextStyle(
        style: const TextStyle(fontSize: FontSize.BIG, color: Colors.black),
        child: this.title ?? SizedBox.shrink());
  }
}
