import 'package:equatable/equatable.dart';

class ProductPrice extends Equatable {
  final String productName;
  final double? price25kg;
  final double price50kg;
  final double priceTon;

  const ProductPrice({
    required this.productName,
    this.price25kg,
    required this.price50kg,
    required this.priceTon,
  });

  @override
  List<Object?> get props => [productName, price25kg, price50kg, priceTon];

  ProductPrice copyWith({
    String? productName,
    double? price25kg,
    double? price50kg,
    double? priceTon,
  }) {
    return ProductPrice(
      productName: productName ?? this.productName,
      price25kg: price25kg ?? this.price25kg,
      price50kg: price50kg ?? this.price50kg,
      priceTon: priceTon ?? this.priceTon,
    );
  }
}