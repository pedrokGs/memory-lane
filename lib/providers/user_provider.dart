import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_lane/providers/user_profile_provider.dart';
import 'package:memory_lane/services/auth_service.dart';

import '../models/user_profile.dart';

class UserProvider extends ChangeNotifier{
  final AuthService _authService;
  final UserProfileProvider _userProfileProvider;

  bool _isLoading = false;
  String? _errorMessage;
  UserProvider(this._authService, this._userProfileProvider);

  User? get currentUser => _authService.currentUser;

  bool get isLoading => _isLoading;

  get errorMessage => _errorMessage;

  Future<UserCredential?> login(String email, String password) async{
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

    final credential = await _authService.login(email, password);

      if (credential.user != null) {
        await _userProfileProvider.fetchUserProfile(credential.user!.uid);
      }

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

      final credential = await _authService.register(email, password);

      if (credential.user != null) {
        final profile = UserProfile(
          uid: credential.user!.uid,
          email: credential.user!.email ?? email,
          displayName: credential.user!.displayName ?? "",
          photoURL: credential.user!.photoURL ?? "",
          createdAt: DateTime.now(),
          favoriteMemoryIds: [],
          preferredCategories: [],
          lastVisitedMemoryId: "",
          visitedMemoryIds: [],
          moodTags: [],
          customTags: [],
          notificationsEnabled: true,
          isPrivate: false,
        );

        await _userProfileProvider.createUserProfile(profile);
      }

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