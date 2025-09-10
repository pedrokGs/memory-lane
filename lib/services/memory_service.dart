import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_lane/models/memory.dart';

class MemoryService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Memory>> fetchMemories() async{
    final List<Memory> memories = [];
    try {
      final data = await _firestore.collection("memories").get();
      for(var doc in data.docs){
        memories.add(Memory.fromJson({...doc.data()}, doc.id));
      }
      return memories;
    } on FirebaseException catch (e) {
      log("[Memory Service]: ${e.message} ");
      throw FirebaseException(plugin: 'firestore', message: "Error on fetching memories. code: ${e.code}");
    }
  }

  Future<Memory?> fetchMemoryById(String id) async{
    try{
      final doc = await _firestore.collection("memories").doc(id).get();
      if(doc.exists){
        return Memory.fromJson({...doc.data()!}, doc.id);
      } else{
        return null;
      }
    } on FirebaseException catch(e){
      log("[Memory Service]: ${e.message}");
      throw FirebaseException(plugin: 'firestore', message: "Error on fetching memory $id. code ${e.code}");
    }
  }

  Future<Memory> addMemory(Memory memory) async{
    try{
      final docRef = await _firestore.collection("memories").add(memory.toJson());
      
      await docRef.update({"id": docRef.id});

      return Memory(
        id: docRef.id,
        title: memory.title,
        description: memory.description,
        category: memory.category,
        photoUrl: memory.photoUrl,
        latitude: memory.latitude,
        longitude: memory.longitude,
        timestamp: memory.timestamp,
      );
    } on FirebaseException catch (e){
      throw FirebaseException(plugin: 'firestore', message: "Error on adding memory");
    }
  }

  Future<Memory> updateMemory(Memory memory) async{
    try{
      final docRef = await _firestore.collection("memories").doc(memory.id);
      await docRef.update(memory.toJson());

      return memory;
    } on FirebaseException catch (e){
      throw FirebaseException(plugin: 'firestore', message: "Error on updating memory");
    }
  }

  Future<void> removeMemory(String id) async{
    try{
      final docRef = await _firestore.collection("memories").doc(id);
      await docRef.delete();
    } on FirebaseException catch (e){
      throw FirebaseException(plugin: 'firestore', message: "Error on deleting memory");
    }
  }
}
