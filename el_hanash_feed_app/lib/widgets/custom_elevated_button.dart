import 'package:feed_price_generator/constants.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor = kSecondaryColor,
  });

  final String buttonText;
  final void Function()? onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: kFontColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kButtonsBorderRadius),
          ),
        ),

        child: Text(
          buttonText,
          style: const TextStyle(fontSize: kBaseFontSize),
        ),
      ),
    );
  }
}
