import 'dart:convert';
import 'dart:developer';

import 'package:tugas_pbm/DTO/login_request.dart';
import 'package:tugas_pbm/config/api_config.dart';
import 'package:http/http.dart' as http;

class Authservice {
  final url = Uri.parse("${ApiConfig.baseUrl}auth/login");

  Future<http.Response?> login(LoginRequest loginParams) async {
    try {
      final respons = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(loginParams.toJson()),
      );
      return respons;
    } catch (e) {
      log("error : $e");
      return null;
    }
  }
}
