import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quick_order_app/app/data/models/request_model.dart';
import 'package:quick_order_app/app/data/services/api_service.dart';

class RequestProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<RequestModel> _requests = [];
  bool _isLoading = false;

  List<RequestModel> get requests => _requests;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchRequests() async {
    _setLoading(true);
    try {
      final response = await _apiService.get('/requests');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        _requests = responseData.map((data) => RequestModel.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load requests');
      }
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> createRequest(List<Map<String, String>> items) async {
    _setLoading(true);
    try {
      final response = await _apiService.post('/requests', {'items': items});
      return response.statusCode == 201;
    } catch (e) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> confirmRequest(String requestId, List<String> confirmedItems) async {
    _setLoading(true);
    try {
      final response = await _apiService.post(
        '/requests/$requestId/confirm',
        {'confirmedItems': confirmedItems},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    } finally {
      _setLoading(false);
    }
  }
}