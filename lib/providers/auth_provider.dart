import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners(); // UI ko loading show karne ke liye

    final result = await ApiService.login(email, password);

    if (result['success']) {
      final token = result['data']['token'];
      final userData = result['data']['user'];

      _user = UserModel.fromJson(userData, token);
      
      // JWT token secure storage me save kar rahe hain
      await _storage.write(key: 'jwt_token', value: token);

      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() async {
    _user = null;
    await _storage.delete(key: 'jwt_token');
    notifyListeners();
  }
}