import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:tugas_pbm/DTO/create_product_request.dart';
import 'package:tugas_pbm/models/product_model.dart';
import 'package:tugas_pbm/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _service = ProductService();
  List<ProductModel> _products = [];
  bool _isLoading = false;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _service.getDataProducts();
      log(_products.toString());
    } catch (e) {
      log("Provider Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createProduct(CreateProductRequest productParams) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _service.createProduct(productParams);

      if (response.statusCode == 201 || response.statusCode == 200) {
        log("Produk berhasil dibuat");
        await fetchProducts();

        return true;
      } else {
        log("Gagal buat produk: ${response.body}");
        return false;
      }
    } catch (e) {
      log("Provider Error (Create): $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
