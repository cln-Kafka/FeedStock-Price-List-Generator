import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/product_price.dart';
import 'product_price_input.dart';

class ProductListSection extends StatelessWidget {
  final Map<String, ProductPrice> productPrices;
  final Function(ProductPrice) onPriceChanged;

  const ProductListSection({
    super.key,
    required this.productPrices,
    required this.onPriceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: kProducts.length,
        itemBuilder: (context, index) {
          final product = kProducts[index];
          final initialPrice = productPrices[product.name];

          return ProductPriceInput(
            product: product,
            initialPrice: initialPrice,
            onPriceChanged: onPriceChanged,
          );
        },
      ),
    );
  }
}
