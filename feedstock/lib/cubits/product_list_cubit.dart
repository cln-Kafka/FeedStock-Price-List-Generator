import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feed_price_generator/models/product.dart';
import 'package:feed_price_generator/services/storage_service.dart';
import 'package:feed_price_generator/services/svg_generator_service.dart';
import 'dart:typed_data';

// Events
abstract class ProductListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProductLists extends ProductListEvent {}

class SaveProductList extends ProductListEvent {
  final ProductList productList;

  SaveProductList(this.productList);

  @override
  List<Object?> get props => [productList];
}

class DeleteProductList extends ProductListEvent {
  final String id;

  DeleteProductList(this.id);

  @override
  List<Object?> get props => [id];
}

class GenerateImage extends ProductListEvent {
  final ProductList productList;

  GenerateImage(this.productList);

  @override
  List<Object?> get props => [productList];
}

// States
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

// Cubit
class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListInitial());

  Future<void> loadProductLists() async {
    emit(ProductListLoading());
    try {
      final lists = await StorageService.loadProductLists();
      emit(ProductListLoaded(lists));
    } catch (e) {
      emit(ProductListError('Failed to load product lists: $e'));
    }
  }

  Future<void> saveProductList(ProductList productList) async {
    try {
      await StorageService.saveProductList(productList);
      await loadProductLists(); // Reload the lists
    } catch (e) {
      emit(ProductListError('Failed to save product list: $e'));
    }
  }

  Future<void> deleteProductList(String id) async {
    try {
      await StorageService.deleteProductList(id);
      await loadProductLists(); // Reload the lists
    } catch (e) {
      emit(ProductListError('Failed to delete product list: $e'));
    }
  }

  Future<void> generateImage(ProductList productList) async {
    try {
      final svgContent = SvgGeneratorService.generatePriceListSvg(productList);
      final imageBytes = await SvgGeneratorService.svgToPngBytes(svgContent);
      emit(ImageGenerated(imageBytes, productList));
    } catch (e) {
      emit(ImageGenerationError('Failed to generate image: $e'));
    }
  }
}
