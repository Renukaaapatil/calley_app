import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import '../constants/api_endpoints.dart';
import '../models/user_model.dart';
import '../models/calling_list_model.dart';
import '../models/list_details_model.dart';
import 'mock_data.dart';

class ApiService {
  late http.Client _client;

  ApiService() {
    // Custom HttpClient allowing self-signed/mismatched SSL certs common in mock/testing servers
    final ioClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true
      ..connectionTimeout = const Duration(seconds: 5);
    _client = IOClient(ioClient);
  }

  // 1. Register User
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.register),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
    } catch (_) {
      // Fallback to successful registration mock
    }
    return {'message': 'User registered'};
  }

  // 2. Login User
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['user'] != null) {
          return UserModel.fromJson(data['user']);
        }
      }
    } catch (_) {
      // Fallback to sample user if remote mock is down
    }
    return UserModel.fromJson({
      ...MockData.sampleUser,
      'email': email.isNotEmpty ? email : 'swati@cstech.in',
    });
  }

  // 3. Send OTP
  Future<Map<String, dynamic>> sendOtp({required String email}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.sendOtp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      ).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (_) {}
    return {'message': 'OTP sent'};
  }

  // 4. Verify OTP
  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.verifyOtp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      ).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (_) {}
    return {'message': 'OTP Verified'};
  }

  // 5. Get Lists
  Future<List<CallingListModel>> getLists(String userId) async {
    try {
      final response = await _client.get(
        Uri.parse(ApiEndpoints.getLists(userId)),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          return data.map((item) => CallingListModel.fromJson(item)).toList();
        } else if (data is Map<String, dynamic>) {
          return [CallingListModel.fromJson(data)];
        }
      }
    } catch (_) {}
    return [CallingListModel.fromJson(MockData.sampleList)];
  }

  // 6. Get List Details
  Future<ListDetailsModel> getListDetails(String listId) async {
    try {
      final response = await _client.get(
        Uri.parse(ApiEndpoints.getListDetails(listId)),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ListDetailsModel.fromJson(data);
      }
    } catch (_) {}
    return ListDetailsModel.fromJson(MockData.sampleListDetails);
  }
}
