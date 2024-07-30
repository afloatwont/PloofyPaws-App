import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/memory/memory_model.dart';
import 'package:ploofypaws/services/repositories/memory/memory_service.dart';

class MemoryProvider with ChangeNotifier {
  final MemoryService _memoryService = MemoryService();
  List<MemoryModel> _memories = [];

  List<MemoryModel> get memories => _memories;

  Future<void> loadMemories(String userId) async {
    try {
      _memories = await _memoryService.getMemories(userId);
      print(_memories.first.title);
      print(_memories[1].title);
      notifyListeners(); // Notify listeners to rebuild UI with loaded data
    } catch (e) {
      // Handle errors (e.g., show a message to the user)
      print(e);
    }
  }

  Future<void> deleteMemory(MemoryModel memory) async {
    try {
      await _memoryService.deleteMemory(memory.userId!, memory);
      _memories.remove(memory);
      notifyListeners(); // Notify listeners to rebuild UI with updated data
    } catch (e) {
      // Handle errors (e.g., show a message to the user)
      print(e);
    }
  }
}
