import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:quick_order_app/app/core/constants/app_config.dart';
import 'package:quick_order_app/app/core/utils/storage_utils.dart';

class ApiService {
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final token = StorageUtils.getToken();
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token', // Standard practice
      if (token != null) 'x-auth-token': token, // As per your backend
    };

    return http.post(url, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final token = StorageUtils.getToken();
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      if (token != null) 'x-auth-token': token,
    };

    return http.get(url, headers: headers);
  }
}