import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:feed_price_generator/models/product_list.dart';
import 'package:feed_price_generator/core/services/storage_service.dart';
import 'package:feed_price_generator/core/services/svg_generator_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_list_state.dart';

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
      final imageBytes = await SvgGeneratorService.generatePriceListImage(
        productList,
      );
      emit(ImageGenerated(imageBytes, productList));
    } catch (e) {
      emit(ImageGenerationError('Failed to generate image: $e'));
    }
  }
}
