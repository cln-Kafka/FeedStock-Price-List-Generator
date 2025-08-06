import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/core/unused_code/pack_row.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productName});

  final String productName;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kCardMargin),
        child: Column(
          children: [
            Text(
              productName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: kSizedBoxBaseHeight),
            const PackRow(weight: '25كغ'),
            const SizedBox(height: kSizedBoxBaseHeight / 2),
            const PackRow(weight: '50كغ'),
            const SizedBox(height: kSizedBoxBaseHeight / 2),
            const PackRow(weight: 'طن'),
          ],
        ),
      ),
    );
  }
}
