import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quick_order_app/app/core/utils/storage_utils.dart';
import 'package:quick_order_app/app/data/models/user_model.dart';
import 'package:quick_order_app/app/data/services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  AuthProvider() {
    loadUserFromStorage();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void loadUserFromStorage() {
    _user = StorageUtils.getUser();
    notifyListeners();
  }

    Future<bool> signup({
    required String email,
    required String password,
    required String role,
  }) async {
    _setLoading(true);
    try {
      final response = await _apiService.post('/signup', {
        'email': email,
        'password': password,
        'role': role,
      });

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(responseData['msg'] ?? 'Signup failed');
      }
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      final response = await _apiService.post('/login', {'email': email, 'password': password});
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _user = UserModel.fromJson(responseData);
        await StorageUtils.saveToken(responseData['token']);
        await StorageUtils.saveUser(_user!);
        notifyListeners();
        return true;
      } else {
        throw Exception(responseData['msg'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _user = null;
    await StorageUtils.clear();
    notifyListeners();
  }
}