import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/models/product.dart';

class ProductPriceInput extends StatefulWidget {
  final Product product;
  final ProductPrice? initialPrice;
  final Function(ProductPrice) onPriceChanged;

  const ProductPriceInput({
    super.key,
    required this.product,
    this.initialPrice,
    required this.onPriceChanged,
  });

  @override
  State<ProductPriceInput> createState() => _ProductPriceInputState();
}

class _ProductPriceInputState extends State<ProductPriceInput> {
  late TextEditingController _price25kgController;
  late TextEditingController _price50kgController;
  late TextEditingController _priceTonController;

  @override
  void initState() {
    super.initState();
    _price25kgController = TextEditingController(
      text: widget.initialPrice?.price25kg?.toString() ?? '',
    );
    _price50kgController = TextEditingController(
      text: widget.initialPrice?.price50kg.toString() ?? '',
    );
    _priceTonController = TextEditingController(
      text: widget.initialPrice?.priceTon.toString() ?? '',
    );

    // Add listeners to update the parent
    _price25kgController.addListener(_updatePrice);
    _price50kgController.addListener(_updatePrice);
    _priceTonController.addListener(_updatePrice);
  }

  @override
  void dispose() {
    _price25kgController.dispose();
    _price50kgController.dispose();
    _priceTonController.dispose();
    super.dispose();
  }

  void _updatePrice() {
    final price25kg = _price25kgController.text.isNotEmpty
        ? double.tryParse(_price25kgController.text)
        : null;
    final price50kg = _price50kgController.text.isNotEmpty
        ? double.tryParse(_price50kgController.text) ?? 0.0
        : 0.0;
    final priceTon = _priceTonController.text.isNotEmpty
        ? double.tryParse(_priceTonController.text) ?? 0.0
        : 0.0;

    final productPrice = ProductPrice(
      productName: widget.product.name,
      price25kg: price25kg,
      price50kg: price50kg,
      priceTon: priceTon,
    );

    widget.onPriceChanged(productPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: kSecondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kFontColor,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (widget.product.has25kg) ...[
                  Expanded(
                    child: TextField(
                      controller: _price25kgController,
                      decoration: const InputDecoration(
                        labelText: '٢٥ كغ',
                        border: OutlineInputBorder(),
                        suffixText: 'ج.م',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: TextField(
                    controller: _price50kgController,
                    decoration: const InputDecoration(
                      labelText: '٥٠ كغ',
                      border: OutlineInputBorder(),
                      suffixText: 'ج.م',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _priceTonController,
                    decoration: const InputDecoration(
                      labelText: 'طن',
                      border: OutlineInputBorder(),
                      suffixText: 'ج.م',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
