import 'package:feed_price_generator/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.titleText});

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText),
      backgroundColor: kBackgroundColor,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66);
}
