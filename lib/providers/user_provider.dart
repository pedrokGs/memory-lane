import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_lane/services/auth_service.dart';

class UserProvider extends ChangeNotifier{
  final AuthService _authService;
  UserProvider(this._authService);

  User? get currentUser => _authService.currentUser;

  Future<UserCredential?> login(String email, String password) async{
    final results = _authService.login(email, password);
    notifyListeners();
    return results;
  }

  Future<UserCredential?> register(String email, String password) async {
    final results = _authService.register(email, password);
    notifyListeners();
    return results;
  }

  Future<void> logout() async {
    final results = _authService.logout();
    notifyListeners();
  }
}