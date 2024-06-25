import 'dart:convert';
import 'package:http/http.dart' as http;

//Auth token we will use to generate a meeting and connect to it
String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI4MjAzYWM0Ni0yNWIyLTQ2ZjktOWE1OS0yYjEyYWQ1OTBhYWYiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcxOTMzNzU3NSwiZXhwIjoxNzIxOTI5NTc1fQ._qzkpjsu--MI47vQw4OvGmc_uNo5SqAbpsEjFUKb5GA";

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
