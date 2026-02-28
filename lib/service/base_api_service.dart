import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:convert';
import 'dart:developer';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;

import '../utils/auth/user_session_manager.dart';
import '../utils/custom screen/custom_exception.dart';

class BaseApiService {
  final String baseUrl = 'https://ejalshakti.gov.in/webapi/api/SJL/';
  static const String ejalShakti = "https://ejalshakti.gov.in/WebAPI/";
  static const String reverseGeocoding = "https://reversegeocoding.nic.in/";
  static const String github = "https://api.github.com/repos/";

  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body, // Accepts raw JSON as string
  }) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');

    headers ??= {};
    headers.putIfAbsent('Content-Type', () => 'application/json');

    headers['APIKey'] = await getEncryptedToken();

    log('POST Request: URL: $url');
    log('POST_Request ency--- : ${body.toString()}');
    log('Headers: ${headers.toString()}');

    await _checkConnectivity();
    final response = await http.post(url, headers: headers, body: body);

    if (response.headers['content-type']?.contains(',') ?? false) {
      response.headers['content-type'] = 'application/json; charset=utf-8';
    }

    log(
      'Response Status Code: ${response.statusCode} : Headers: ${response.headers}',
    );
    log('Response Body: ${response.body}');

    return _processResponse(response);
  }

  Future<dynamic> get(
    String endpoint, {
    ApiType apiType = ApiType.baseUrl,
    Map<String, String>? headers,
  }) async {
    final String baseUrl = getBaseUrl(apiType);
    final Uri url = Uri.parse('$baseUrl$endpoint');

    headers ??= {};
    headers.putIfAbsent('Content-Type', () => 'application/json');

    headers['APIKey'] = await getEncryptedToken();

    log('GET Request: URL: $url');
    log('GET Request: Headers: ${headers.toString()}');

    await _checkConnectivity();

    final response = await http.get(url, headers: headers);

    if (response.headers['content-type']?.contains(',') ?? false) {
      response.headers['content-type'] = 'application/json; charset=utf-8';
    }
    log('Response: ${response.statusCode} : Body: ${response.body}');

    return _processResponse(response);
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw NetworkException(
        'No internet connection. Please check your connection and try again.',
      );
    }
  }

  dynamic _processResponse(http.Response response) {
    try {
      switch (response.statusCode) {
        case 200:
          final rawJson = json.decode(response.body);

          return rawJson;

        case 400:
          throw ApiException(
            'Something went wrong with your request. Please check and try again. \n Error Code : 400',
            response.statusCode.toString(),
          );

        case 401:
          throw ApiException(
            'Your session has expired or you are not authorized. Please log in again. \n Error Code : 401',
            response.statusCode.toString(),
          );

        case 404:
          throw ApiException(
            'Oops! The page or service you’re trying to reach is not available. Please contact support. \n Error Code : 404',
            response.statusCode.toString(),
          );
        case 405:
          throw ApiException(
            'The requested resource does not support http method . \n Error Code : 405',
            response.statusCode.toString(),
          );

        case 408:
          throw ApiException(
            'The request timed out. Please check your connection and try again. \n Error Code : 408',
            response.statusCode.toString(),
          );

        case 500:
          throw ApiException(
            'Server encountered an error. Please try again later. \n Error Code : 500',
            response.statusCode.toString(),
          );

        case 502:
          throw ApiException(
            'We’re experiencing server issues. Please try again shortly. \n Error Code : 404',
            response.statusCode.toString(),
          );

        default:
          throw ApiException(
            'Unexpected error occurred . Please try again after some time.',
            response.statusCode.toString(),
          );
      }
    } catch (e) {
      if (e is AppException) {
        rethrow; // Let known exceptions pass through
      }
      throw ApiException(
        'An unexpected error occurred: $e',
        response.statusCode.toString(),
      );
    }
  }

  String getBaseUrl(ApiType apiType) {
    switch (apiType) {
      case ApiType.baseUrl:
        return baseUrl;
        case ApiType.ejalShakti:
        return ejalShakti;
      case ApiType.reverseGeocoding:
        return reverseGeocoding;
      case ApiType.github:
        return github;
    }
  }

  String handleErrorResp(String responseBody, String defMessage) {
    final Map<String, dynamic> jsonData = jsonDecode(responseBody);
    //   final String errType = jsonData['ExceptionType'] ?? '';
    final String message = jsonData['ExceptionMessage'] ?? defMessage;
    String res = " $message";
    return res;
  }
}

Future<String> getEncryptedToken() async {
  final session = UserSessionManager();

  await session.init();

  return session.token.toString();
}

enum ApiType { baseUrl,ejalShakti, reverseGeocoding, github }
