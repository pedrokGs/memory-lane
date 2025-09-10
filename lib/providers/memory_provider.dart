import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:memory_lane/models/memory.dart';
import 'package:memory_lane/services/memory_service.dart';

class MemoryProvider extends ChangeNotifier {
  final MemoryService _memoryService = MemoryService();
  List<Memory> _memoriesList = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getMemories() async{
    _isLoading = true;
    notifyListeners();
    try{
      _memoriesList = await _memoryService.fetchMemories();
    } catch (e){
      log("$e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<Memory> addMemory(Memory memory) async {
    try{
      final newMemory = await _memoryService.addMemory(memory);
      _memoriesList.add(newMemory);
      notifyListeners();
      return newMemory;
    } catch(e){
      log("[MemoryProvider] error on adding memory: $e");
      rethrow;
    }
  }

  Future<void> removeMemory(Memory memory) async {
    try {
      await _memoryService.removeMemory(memory.id);
      _memoriesList.removeWhere((element) => element.id == memory.id);
      notifyListeners();
    } catch (e) {
      log("[MemoryProvider] error on removing memory: $e");
      rethrow;
    }
  }

  Future<Memory> updateMemory(Memory memory) async {
    try {
      final updatedMemory = await _memoryService.updateMemory(memory);

      final index = _memoriesList.indexWhere((m) => m.id == memory.id);
      if (index != -1) {
        _memoriesList[index] = updatedMemory;
        notifyListeners();
      }

      return updatedMemory;
    } catch (e) {
      log("[MemoryProvider] error on updating memory: $e");
      rethrow;
    }
  }



}
