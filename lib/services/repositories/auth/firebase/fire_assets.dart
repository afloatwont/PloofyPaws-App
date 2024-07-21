import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UrlProvider with ChangeNotifier {
  Map<String, String> _urlMap = {};

  UrlProvider() {
    loadUrlMap();
    preloadUrls();
  }

  final List<String> folders = [
    "placeholders",
    "auth",
    "content",
    "onboarding",
    "pet_onboarding",
    "services",
  ];

  Map<String, String> get urlMap => _urlMap;

  Future<void> loadUrlMap() async {
    final prefs = await SharedPreferences.getInstance();
    final String? urlMapString = prefs.getString('urlMap');
    if (urlMapString != null) {
      _urlMap = Map<String, String>.from(json.decode(urlMapString));
      notifyListeners();
      debugPrint("Assets Loaded");
    }
  }

  Future<void> _saveUrlMap() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('urlMap', json.encode(_urlMap));
  }

  Future<void> preloadUrls() async {
    // Get the reference to the directory
    for(String s in folders)
    {
      final ref =
        FirebaseStorage.instance.ref().child('assets/images/$s');

    // List all files in the directory
    final listResult = await ref.listAll();
    print(listResult.items.length);
    // Iterate through the list of files and get their download URLs
    for (var item in listResult.items) {
      final path = item.fullPath;
      debugPrint("path: $path");
      if (!_urlMap.containsKey(path)) {
        final url = await item.getDownloadURL();
        print(url);
        _urlMap[path] = url;
      }
    }}
    await _saveUrlMap();
    notifyListeners();
  }
}

Future<String> getImageUrl(String imagePath) async {
  final ref = FirebaseStorage.instance.ref().child(imagePath);
  return await ref.getDownloadURL();
}
