import 'package:flutter/material.dart';

class PackRow extends StatelessWidget {
  const PackRow({super.key, required this.weight});

  final String weight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            // controller: controllers[product.name]!['50kg'],
            decoration: InputDecoration(
              labelText: weight,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
