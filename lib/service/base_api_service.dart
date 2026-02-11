import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import '../utils/custom screen/custom_exception.dart';

class BaseApiService {

  // ================= BASE URL =================

  final String _baseUrl = 'https://ejalshakti.gov.in/WebAPI/';

  static const String ejalShakti = "https://ejalshakti.gov.in/WebAPI/";
  static const String _masterdic = "https://ejalshakti.gov.in/WebAPI/api/RPWSS/RPWSS_Result_Lsit_BY_Directory";
  static const String reverseGeocoding = "https://reversegeocoding.nic.in/";
  static const String github = "https://api.github.com/repos/";


  // ================= TOKEN =================

  String? _token;

  void setToken(String token) {
    _token = token;
    log("🔐 Token Set Successfully");
  }


  // ================= HEADERS =================

  Map<String, String> _defaultHeaders({Map<String, String>? extra}) {

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (_token != null && _token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_token';
    }

    if (extra != null) {
      headers.addAll(extra);
    }

    return headers;
  }


  // ================= POST =================

  Future<dynamic> post(
      String endpoint, {
        Map<String, String>? headers,
        dynamic body,
      }) async {

    final Uri url = Uri.parse('$_baseUrl$endpoint');

    final finalHeaders = _defaultHeaders(extra: headers);

    log('➡️ POST: $url');
    log('🧾 Headers: $finalHeaders');
    log('📤 Body: $body');

    await _checkConnectivity();

    try {

      final response = await http
          .post(
        url,
        headers: finalHeaders,
        body: body,
      )
          .timeout(const Duration(seconds: 30));

      log('⬅️ Status: ${response.statusCode}');
      log('📦 Body: ${response.body}');

      return _processResponse(response);

    } on TimeoutException {
      throw NetworkException("Request timeout. Please try again.");
    }
  }


  // ================= GET =================

  Future<dynamic> get(
      String endpoint, {
        ApiType apiType = ApiType.ejalShakti,
        Map<String, String>? headers,
      }) async {

    final String baseUrl = getBaseUrl(apiType);
    final Uri url = Uri.parse('$baseUrl$endpoint');

    final finalHeaders = _defaultHeaders(extra: headers);

    log('➡️ GET: $url');
    log('🧾 Headers: $finalHeaders');

    await _checkConnectivity();

    try {

      final response = await http
          .get(
        url,
        headers: finalHeaders,
      )
          .timeout(const Duration(seconds: 30));

      log('⬅️ Status: ${response.statusCode}');
      log('📦 Body: ${response.body}');

      return _processResponse(response);

    } on TimeoutException {
      throw NetworkException("Request timeout. Please try again.");
    }
  }


  // ================= CONNECTIVITY =================

  Future<void> _checkConnectivity() async {

    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {

      throw NetworkException(
        'No internet connection. Please check and try again.',
      );
    }
  }


  // ================= RESPONSE HANDLER =================

  dynamic _processResponse(http.Response response) {

    try {

      switch (response.statusCode) {

        case 200:
          return json.decode(response.body);


        case 400:
          throw ApiException(
            'Bad request. Please verify inputs.',
            '400',
          );


        case 401:
          throw ApiException(
            'Session expired. Please login again.',
            '401',
          );


        case 403:
          throw ApiException(
            'Access denied.',
            '403',
          );


        case 404:
          throw ApiException(
            'Resource not found.',
            '404',
          );


        case 405:
          throw ApiException(
            'Method not allowed.',
            '405',
          );


        case 408:
          throw ApiException(
            'Request timeout.',
            '408',
          );


        case 500:
          throw ApiException(
            'Internal server error.',
            '500',
          );


        case 502:
          throw ApiException(
            'Bad gateway.',
            '502',
          );


        default:
          throw ApiException(
            'Unexpected error occurred.',
            response.statusCode.toString(),
          );
      }

    } catch (e) {

      if (e is AppException) {
        rethrow;
      }

      throw ApiException(
        'Unexpected error: $e',
        response.statusCode.toString(),
      );
    }
  }


  // ================= BASE URL =================

  String getBaseUrl(ApiType apiType) {

    switch (apiType) {

      case ApiType.ejalShakti:
        return ejalShakti;

      case ApiType.reverseGeocoding:
        return reverseGeocoding;

      case ApiType.github:
        return github;
    }
  }


  // ================= ERROR MESSAGE =================

  String handleErrorResp(String responseBody, String defMessage) {

    final Map<String, dynamic> jsonData = jsonDecode(responseBody);

    final String message =
        jsonData['ExceptionMessage'] ?? defMessage;

    return message;
  }
}


// ================= API TYPE =================

enum ApiType {
  ejalShakti,
  reverseGeocoding,
  github,
}
