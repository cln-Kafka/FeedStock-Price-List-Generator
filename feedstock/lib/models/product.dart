import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final bool has25kg;

  const Product(this.name, this.has25kg);

  @override
  List<Object?> get props => [name, has25kg];
}
