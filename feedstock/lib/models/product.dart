import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final bool has25kg;

  const Product(this.name, this.has25kg);

  @override
  List<Object?> get props => [name, has25kg];
}

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

class ProductList extends Equatable {
  final String id;
  final String date;
  final String day;
  final List<ProductPrice> products;
  final DateTime createdAt;

  const ProductList({
    required this.id,
    required this.date,
    required this.day,
    required this.products,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, date, day, products, createdAt];

  ProductList copyWith({
    String? id,
    String? date,
    String? day,
    List<ProductPrice>? products,
    DateTime? createdAt,
  }) {
    return ProductList(
      id: id ?? this.id,
      date: date ?? this.date,
      day: day ?? this.day,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'day': day,
      'products': products
          .map(
            (p) => {
              'productName': p.productName,
              'price25kg': p.price25kg,
              'price50kg': p.price50kg,
              'priceTon': p.priceTon,
            },
          )
          .toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
      id: json['id'],
      date: json['date'],
      day: json['day'],
      products: (json['products'] as List)
          .map(
            (p) => ProductPrice(
              productName: p['productName'],
              price25kg: p['price25kg'],
              price50kg: p['price50kg'],
              priceTon: p['priceTon'],
            ),
          )
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
