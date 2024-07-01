import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ploofypaws/pages/ai/system_instructions.dart';
import 'package:ploofypaws/services/alert/alert_service.dart';

class GenModel {
  late final GenerativeModel _model;
  final getIt = GetIt.instance;
  late AlertService _alertService;

  void init() {
    _alertService = getIt.get<AlertService>();
    String key = dotenv.env['PLOOFYBOT_KEY'] ?? "key";
    _model = GenerativeModel(
        model: "gemini-1.5-pro",
        apiKey: key,
        systemInstruction: Content("system", <Part>[TextPart(instructions)]));
  }

  Future<String> getResponse(String prompt) async {
    String res = "";
    GenerateContentResponse response;
    try {
      response = await _model.generateContent([Content.text(prompt)]);
      res = response.text ?? "";
    } catch (e) {
      print(e.toString());
      _alertService.showToast(text: e.toString());
    }
    return res;
  }
}
