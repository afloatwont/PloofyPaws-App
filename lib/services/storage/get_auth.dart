import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<Auth?> getAuth() async {
//   final storage = await SharedPreferences.getInstance();
//
//   final data = storage.getString('auth');
//   if (data == null) return null;
//
//   final auth = Auth.fromJson(jsonDecode(data));
//   return auth;
// }

Future<void> deleteAuth() async {
  final storage = await SharedPreferences.getInstance();

  await storage.remove('auth');
}

printAuth() async {
  final storage = await SharedPreferences.getInstance();
  debugPrint(storage.getString('auth'));
}

// Future<void> invalidateAuth() async {
//   final storage = await SharedPreferences.getInstance();
//
//     final auth = await getAuth();
//
//   if (auth != null) {
//     auth.accessToken = '${auth.accessToken}a';
//     await storage.setString('auth', jsonEncode(auth));
//   }
// }
