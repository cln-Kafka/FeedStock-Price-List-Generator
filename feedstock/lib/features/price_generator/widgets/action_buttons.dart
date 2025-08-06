import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../core/widgets/custom_elevated_button.dart';

class ActionButtons extends StatelessWidget {
  final bool isGenerating;
  final VoidCallback onGeneratePressed;
  final VoidCallback onResetPressed;

  const ActionButtons({
    super.key,
    required this.isGenerating,
    required this.onGeneratePressed,
    required this.onResetPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButton(
            buttonText: isGenerating
                ? "جاري الإنشاء..."
                : "إنشاء قائمة الأسعار",
            onPressed: isGenerating ? null : onGeneratePressed,
            backgroundColor: kCTAColor,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: onResetPressed,
          icon: const Icon(Icons.delete),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(kSecondaryColor),
            foregroundColor: WidgetStateProperty.all<Color>(kFontColor),
          ),
        ),
      ],
    );
  }
}
