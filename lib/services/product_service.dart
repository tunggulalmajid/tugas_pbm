import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tugas_pbm/config/api_config.dart';
import 'package:tugas_pbm/models/product_model.dart';
import 'package:tugas_pbm/models/user_model.dart';

class ProductService {
  final url = Uri.parse("${ApiConfig.baseUrl}products");

  Future<List<ProductModel>> getDataProducts() async {
    try {
      final token = await UserModel.getToken();
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);

        List<dynamic> listData = body['data']['products'];

        return listData.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception("Gagal: ${response.statusCode}");
      }
    } catch (e) {
      log("error product service : $e");
      rethrow;
    }
  }
}
