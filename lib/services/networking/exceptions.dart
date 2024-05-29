import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class APIError {
  String? message;
  int? statusCode;
  Map<String, dynamic>? fieldErrors;
  bool isServerError = false;
  bool noInternet;

  APIError(Response? response, {this.noInternet = false}) {
    noInternet = noInternet;
    statusCode = response?.statusCode;

    if (response == null) {
      isServerError = true;
      return;
    }

    switch (response.statusCode) {
      case 422:
      case 400:
        message = response.data['errors']?['message'];
        fieldErrors = response.data['errors'];
        break;
      case 401:
        if (kDebugMode) {
          print('401');
        }
        // refreshToken();
        break;
      case 403:
        message = 'Forbidden';
        break;
      case 404:
        message = 'Not Found';
        break;
      case 500:
        isServerError = true;
        break;
      case 502:
        isServerError = true;
        break;

      default:
        throw ErrorDescription('Exception status code: ${response.statusCode} is not handled');
    }
  }

  @override
  String toString() {
    return '''API ERROR: 
message: $message
statusCode: $statusCode
fieldErrors: $fieldErrors
isServerError: $isServerError
noInternet: $noInternet
''';
  }
}
