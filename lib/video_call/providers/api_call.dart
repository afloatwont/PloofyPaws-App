import 'dart:convert';
import 'package:http/http.dart' as http;

//Auth token we will use to generate a meeting and connect to it
String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI1YjJjNjllNy01OGFjLTQ1NGMtYTdmNC02ZTY0Y2U4OGM1MWIiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcyMDAwNjM4MCwiZXhwIjoxNzIyNTk4MzgwfQ.svA2G6z3t80rZZRFYfVoh22K-YUGkq0pIxRl9syN5_E";

// API call to create meeting
Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

//Destructuring the roomId from the response
  print(json.decode(httpResponse.body)['roomId']);
  return json.decode(httpResponse.body)['roomId'];
}
