import 'package:flutter/material.dart';
import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/models/product.dart';
import 'package:intl/intl.dart';

class CachedProductListItem extends StatelessWidget {
  final ProductList productList;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CachedProductListItem({
    super.key,
    required this.productList,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: kSecondaryColor,
      child: ListTile(
        title: Text(
          'قائمة أسعار - ${productList.date}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: kFontColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اليوم: ${productList.day}',
              style: const TextStyle(color: kFontColor2),
            ),
            Text(
              'عدد المنتجات: ${productList.products.length}',
              style: const TextStyle(color: kFontColor2),
            ),
            Text(
              'تاريخ الإنشاء: ${DateFormat('yyyy/MM/dd HH:mm').format(productList.createdAt)}',
              style: const TextStyle(color: kFontColor2, fontSize: 12),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit, color: kCTAColor),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
        onTap: onEdit,
      ),
    );
  }
}
