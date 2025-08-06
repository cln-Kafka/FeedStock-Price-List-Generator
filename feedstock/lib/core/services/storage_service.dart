import 'dart:convert';
import 'dart:developer';
import 'package:feed_price_generator/models/product_list.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class StorageService {
  static const String _fileName = 'product_lists.json';
  static const int _maxCachedLists = 20;

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  static Future<List<ProductList>> loadProductLists() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return [];
      }

      final String contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents);

      return jsonList.map((json) => ProductList.fromJson(json)).toList()..sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      ); // Sort by newest first
    } catch (e) {
      log('Error loading product lists: $e');
      return [];
    }
  }

  static Future<void> saveProductList(ProductList productList) async {
    try {
      final file = await _localFile;
      List<ProductList> existingLists = await loadProductLists();

      // Remove existing list with same ID if exists
      existingLists.removeWhere((list) => list.id == productList.id);

      // Add new list at the beginning
      existingLists.insert(0, productList);

      // Keep only the most recent lists
      if (existingLists.length > _maxCachedLists) {
        existingLists = existingLists.take(_maxCachedLists).toList();
      }

      // Convert to JSON and save
      final List<Map<String, dynamic>> jsonList = existingLists
          .map((list) => list.toJson())
          .toList();

      await file.writeAsString(json.encode(jsonList));
    } catch (e) {
      log('Error saving product list: $e');
    }
  }

  static Future<void> deleteProductList(String id) async {
    try {
      final file = await _localFile;
      List<ProductList> existingLists = await loadProductLists();

      existingLists.removeWhere((list) => list.id == id);

      final List<Map<String, dynamic>> jsonList = existingLists
          .map((list) => list.toJson())
          .toList();

      await file.writeAsString(json.encode(jsonList));
    } catch (e) {
      log('Error deleting product list: $e');
    }
  }

  static Future<void> clearAllProductLists() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      log('Error clearing product lists: $e');
    }
  }
}
