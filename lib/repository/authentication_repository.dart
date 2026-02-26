import 'dart:convert';

import '../models/panchayat/login_response.dart';
import '../models/panchayat/panchayat_login_response.dart';
import '../service/base_api_service.dart';
import '../utils/global_exception_handler.dart';

class AuthenticaitonRepository {
  final BaseApiService _apiService = BaseApiService();

  Future<PanchayatLoginResponse> loginUser(
    String username,
    String password
  ) async {
    try {
      // Call the POST method from BaseApiService
     // https://localhost:5000/api/SJL/PanchayatLogin
      final response = await _apiService.post(
        'PanchayatLogin',
        body: jsonEncode({
          'userName': username,
          'password': password
        }),
        apiType: ApiType.egramswaraj,
      );

      return PanchayatLoginResponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
