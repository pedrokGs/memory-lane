import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_lane/services/auth_service.dart';

class UserProvider extends ChangeNotifier{
  final AuthService _authService;
  bool _isLoading = false;
  String? _errorMessage;
  UserProvider(this._authService);

  User? get currentUser => _authService.currentUser;

  bool get isLoading => _isLoading;

  get errorMessage => _errorMessage;

  Future<UserCredential?> login(String email, String password) async{
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

    await _authService.login(email, password);
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "Erro desconhecido";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }


  Future<UserCredential?> register(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _authService.register(email, password);
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "Erro desconhecido";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<void> logout() async {
    _isLoading = true;
    final results = _authService.logout();
    _isLoading = false;
    notifyListeners();
  }
}