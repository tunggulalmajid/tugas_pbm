import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tugas_pbm/DTO/submit_request.dart';
import 'package:tugas_pbm/config/api_config.dart';
import 'package:tugas_pbm/models/user_model.dart';

class SubmitService {
  final url = Uri.parse("${ApiConfig.baseUrl}products");

  Future<http.Response> submitTugas(SubmitRequest submitParams) async {
    try {
      final token = await UserModel.getToken();
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(submitParams.toJson()),
      );
      return response;
    } catch (e) {
      log("error submit service : $e");
      rethrow;
    }
  }
}
