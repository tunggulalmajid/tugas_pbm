import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tugas_pbm/DTO/login_request.dart';
import 'package:tugas_pbm/models/user_model.dart';
import 'package:tugas_pbm/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  final Authservice _service = Authservice();

  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<bool> login(LoginRequest loginParams) async {
    _isLoading = true;
    notifyListeners();
    bool success = false;
    try {
      final response = await _service.login(loginParams);
      if (response!.statusCode == 200) {
        final data = jsonDecode(response.body);
        _user = UserModel.fromJson(data['data']['user']);
        _user!.saveToken(data['data']['token']);
        success = true;
        notifyListeners();
        return success;
      } else {
        return success;
      }
    } catch (e) {
      log("error ini : $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
