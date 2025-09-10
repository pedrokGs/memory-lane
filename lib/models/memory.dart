import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_lane/Enums/memory_category.dart';

class Memory {
  final String id;
  final String title;
  final String description;
  final MemoryCategory category;
  final String photoUrl;
  final double latitude;
  final double longitude;
  final Timestamp timestamp;

  Memory({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.photoUrl,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "category": category,
    "photoUrl": photoUrl,
    "latitude": latitude,
    "longitude": longitude,
    "timestamp": timestamp,
  };

  factory Memory.fromJson(Map<String, dynamic> json, String id) {
    MemoryCategory category;
    try{
      category = MemoryCategory.values.firstWhere((e)=> e.name == json["category"]);
    } catch(e){
      category = MemoryCategory.none;
    }

    return Memory(
      id: id,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      category: category,
      photoUrl: json["photoUrl"] ?? "",
      latitude: json["latitude"] as double ?? 0.00,
      longitude: json["longitude"] as double ?? 0.00,
      timestamp: json["timestamp"] ?? Timestamp.now(),
    );
  }
}
