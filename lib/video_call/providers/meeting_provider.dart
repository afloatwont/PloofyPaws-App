import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/meeting.dart';

class MeetingProvider with ChangeNotifier {
  Meeting? _currentMeeting;

  Meeting? get currentMeeting => _currentMeeting;

  Future<void> createMeeting() async {
    final tokenResponse =
        await http.get(Uri.parse('http://192.168.19.249:5678/get-token'));
    final token = await json.decode(tokenResponse.body)['token'];
    print(token);
    final response = await http.post(
      Uri.parse('http://192.168.19.249:5678/create-meeting'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'token': token}),
    );

    final responseData = await json.decode(response.body);
    _currentMeeting = Meeting(id: responseData['roomId'], token: token);

    notifyListeners();
  }

  void currMeeting(String m) {
    _currentMeeting = Meeting(
        id: m,
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTkyMDk4OTksImFwaWtleSI6IjgyMDNhYzQ2LTI1YjItNDZmOS05YTU5LTJiMTJhZDU5MGFhZiIsInBlcm1pc3Npb25zIjpbImFsbG93X2pvaW4iLCJhbGxvd19tb2QiXX0.c6T0i6Lic2nDWxIsMpDn0jO-hxR09_x0yyxHknAmeSs");
    notifyListeners();
  }
}
