part of 'product_list_cubit.dart';

abstract class ProductListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<ProductList> productLists;

  ProductListLoaded(this.productLists);

  @override
  List<Object?> get props => [productLists];
}

class ProductListError extends ProductListState {
  final String message;

  ProductListError(this.message);

  @override
  List<Object?> get props => [message];
}

class ImageGenerated extends ProductListState {
  final Uint8List imageBytes;
  final ProductList productList;

  ImageGenerated(this.imageBytes, this.productList);

  @override
  List<Object?> get props => [imageBytes, productList];
}

class ImageGenerationError extends ProductListState {
  final String message;

  ImageGenerationError(this.message);

  @override
  List<Object?> get props => [message];
}
