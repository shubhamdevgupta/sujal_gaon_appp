import 'dart:convert';
import '../models/login_response.dart';
import '../service/base_api_service.dart';
import '../utils/global_exception_handler.dart';

class AuthenticaitonRepository {
  final BaseApiService _apiService = BaseApiService();

  Future<LoginResponse> loginUser(
      String phoneNumber, String password, String txtSalt, int appId) async {
    try {
      // Call the POST method from BaseApiService
      final response = await _apiService.post('APIMobileA/Login',
        body: jsonEncode({
          'loginid': phoneNumber,
          'password': password,
          'txtSaltedHash': txtSalt,
          'App_id': appId
        }));

      return LoginResponse.fromJson(response);
    } catch (e,stackTrace) {
      GlobalExceptionHandler.handleException(e as Exception,stackTrace: stackTrace);
      rethrow;
    }
  }

}
