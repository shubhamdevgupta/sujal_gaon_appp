import 'dart:convert';

import '../models/login_response.dart';
import '../service/base_api_service.dart';
import '../utils/global_exception_handler.dart';

class AuthenticaitonRepository {
  final BaseApiService _apiService = BaseApiService();

  Future<LoginResponseModel> loginUser(
    String username,
    String password,
    String appId,
  ) async {
    try {
      // Call the POST method from BaseApiService
      final response = await _apiService.post(
        'LDAPLogin',
        body: jsonEncode({
          'userName': username,
          'password': password,
          'applicationId': appId,
        }),
        apiType: ApiType.egramswaraj,
      );

      return LoginResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
