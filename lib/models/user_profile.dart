import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;
  final DateTime createdAt;

  final List<String> favoriteMemoryIds;
  final List<String> preferredCategories;
  final String lastVisitedMemoryId;
  final List<String> visitedMemoryIds;

  final List<String> moodTags;
  final List<String> customTags;

  final bool notificationsEnabled;
  final bool isPrivate;

  UserProfile({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.createdAt,
    required this.favoriteMemoryIds,
    required this.preferredCategories,
    required this.lastVisitedMemoryId,
    required this.visitedMemoryIds,
    required this.moodTags,
    required this.customTags,
    required this.notificationsEnabled,
    required this.isPrivate,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json["uid"],
      email: json["email"],
      displayName: json["displayName"] ?? "",
      photoURL: json["photoURL"] ?? "",
      createdAt: (json["createdAt"] as Timestamp).toDate(),
      favoriteMemoryIds: List<String>.from(json["favoriteMemories"] ?? []),
      preferredCategories: List<String>.from(json["preferredCategories"] ?? []),
      lastVisitedMemoryId: json["lastVisitedMemoryId"] ?? "",
      visitedMemoryIds: List<String>.from(json["visitedMemories"] ?? []),
      moodTags: List<String>.from(json["moodTags"] ?? []),
      customTags: List<String>.from(json["customTags"] ?? []),
      notificationsEnabled: json["notificationsEnabled"] ?? false,
      isPrivate: json["isPrivate"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "displayName": displayName,
    "photoURL": photoURL,
    "createdAt": Timestamp.fromDate(createdAt),
    "favoriteMemories": favoriteMemoryIds,
    "preferredCategories": preferredCategories,
    "lastVisitedMemoryId": lastVisitedMemoryId,
    "visitedMemories": visitedMemoryIds,
    "moodTags": moodTags,
    "customTags": customTags,
    "notificationsEnabled": notificationsEnabled,
    "isPrivate": isPrivate,
  };
}
