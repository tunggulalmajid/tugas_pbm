import 'dart:developer';

import 'package:flutter/foundation.dart';
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
}
