import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tugas_pbm/DTO/submit_request.dart';
import 'package:tugas_pbm/services/submit_service.dart';

class SubmitProvider with ChangeNotifier {
  final SubmitService _service = SubmitService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> submitTugas(SubmitRequest params) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _service.submitTugas(params);

      if (response.statusCode == 201 || response.statusCode == 200) {
        log("Submit Tugas Berhasil");
        return true;
      } else {
        log("Submit Gagal: ${response.body}");
        return false;
      }
    } catch (e) {
      log("Error di SubmitProvider: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
