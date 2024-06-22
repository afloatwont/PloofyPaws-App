import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ploofypaws/services/networking/exceptions.dart';

const _baseUrl = "";

class ApiProvider {
  static const _debugMode = false;

  final Dio _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  // ApiProvider() {
  //   _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
  //     final auth = await getAuth();
  //
  //     if (auth != null) {
  //       options.headers['Authorization'] = 'Bearer ${auth.accessToken}';
  //     }
  //
  //     return handler.next(options);
  //   }, onError: (DioException error, handler) async {
  //     debugPrint('API ${error.response?.statusCode}: ${error.response?.data}');
  //     if (error.response?.statusCode == 401) {
  //       if (await refreshToken()) {
  //         return handler.resolve(await _retry(error.requestOptions));
  //       }
  //     }
  //     return handler.next(error);
  //   }));
  //
  //   if (_debugMode) {
  //     _dio.interceptors.add(LoggingInterceptor());
  //   }
  // }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  // Future<bool> refreshToken() async {
  //   final auth = await getAuth();
  //   if (auth == null) return false;
  //
  //   final refreshToken = auth.refreshToken;
  //
  //   final storage = await SharedPreferences.getInstance();
  //
  //   try {
  //     Response response = await _dio.post(
  //       '/solis/v1/auth/refresh-token/',
  //       data: {'refreshToken': refreshToken},
  //     );
  //     debugPrint('Refresh Token Success');
  //
  //     auth.accessToken = response.data['data']['access_token'];
  //     auth.refreshToken = response.data['data']['refresh_token'];
  //
  //     storage.setString('auth', jsonEncode(auth));
  //
  //     return true;
  //   } on DioException catch (_) {
  //     storage.remove('auth');
  //     GetIt.instance<NavigationService>().pushNamedAndRemoveUntil('/', (route) => false);
  //
  //     return false;
  //   }
  // }

  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
  }) async {
    dynamic responseJson;

    queryParameters?.removeWhere((key, value) => value == null);

    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options ?? Options(headers: headers),
      );
      if (options?.responseType == ResponseType.bytes) {
        return response;
      }
      responseJson = _parseResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown && e.message!.contains('SocketException')) {
        debugPrint('no internet');
        throw APIError(null, noInternet: true);
      }
      throw APIError(e.response);
    }
    return responseJson;
  }

  Future<SuccessResponse> post(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Object? data,
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        onSendProgress: onSendProgress,
      );
      return _parseResponse(response);
    } on SocketException {
      throw APIError(null, noInternet: true);
    } on DioException catch (e) {
      throw APIError(e.response);
    }
  }

  Future<SuccessResponse> put(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _parseResponse(response);
    } on SocketException {
      throw APIError(null, noInternet: true);
    } on DioException catch (e) {
      throw APIError(e.response);
    }
  }

  Future<SuccessResponse> patch(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _parseResponse(response);
    } on SocketException {
      throw APIError(null, noInternet: true);
    } on DioException catch (e) {
      throw APIError(e.response);
    }
  }

  Future<SuccessResponse> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _parseResponse(response);
    } on SocketException {
      throw APIError(null, noInternet: true);
    } on DioException catch (e) {
      throw APIError(e.response);
    }
  }

  SuccessResponse _parseResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return SuccessResponse(data: response.data);
      case 204:
        return SuccessResponse(data: null);

      default:
        throw ErrorDescription('Success status code: ${response.statusCode} is not handled');
    }
  }
}

class SuccessResponse {
  dynamic data;
  static const errors = null;

  SuccessResponse({required this.data}) {
    try {
      data = data == null ? null : data['data'];
    } on TypeError {
      data = data;
    }
  }
}
