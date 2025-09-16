import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class UserProfileProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  String? _errorMessage;
  UserProfile? _userProfile;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserProfile? get userProfile => _userProfile;

  Future<void> createUserProfile(UserProfile profile) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _firestore
          .collection("UserProfiles")
          .doc(profile.uid)
          .set(profile.toJson());

      _userProfile = profile;
    } catch (e) {
      _errorMessage = "Erro ao criar perfil: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserProfile(String uid) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final doc = await _firestore.collection("UserProfiles").doc(uid).get();

      if (doc.exists) {
        _userProfile = UserProfile.fromJson(doc.data()!);
      } else {
        _userProfile = null;
      }
    } catch (e) {
      _errorMessage = "Erro ao buscar perfil: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> updates) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _firestore.collection("UserProfiles").doc(uid).update(updates);

      if (_userProfile != null && _userProfile!.uid == uid) {
        final newData = {..._userProfile!.toJson(), ...updates};
        _userProfile = UserProfile.fromJson(newData);
      }
    } catch (e) {
      _errorMessage = "Erro ao atualizar perfil: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
