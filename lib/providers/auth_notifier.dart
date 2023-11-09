import 'package:flutter/material.dart';
import 'auth_provider.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthProvider _authProvider = AuthProvider();
  bool _isRegistered = false;
  bool _isLoggedIn = false;

  bool get isRegistered => _isRegistered;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> register(String email, String password, BuildContext context) async {
    _isRegistered = await _authProvider.register(email, password, context);
    notifyListeners();
    return true;
  }

  Future<bool> login(String email, String password, BuildContext context) async {
    _isLoggedIn = await _authProvider.login(email, password, context);
    notifyListeners();
    return true;
  }
}
