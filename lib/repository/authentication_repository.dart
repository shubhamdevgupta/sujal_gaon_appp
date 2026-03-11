import 'dart:convert';

import 'package:jal_sanchalan/models/njm_ftk_response/njm_ftk_dashboard_response.dart';
import 'package:jal_sanchalan/models/njm_ftk_response/njm_ftk_login_response.dart';
import 'package:jal_sanchalan/models/njm_ftk_response/password_login.dart';

import '../models/njm_ftk_response/habitation_assest.dart';
import '../models/panchayat/panchayat_login_response.dart';
import '../models/update_password.dart';
import '../service/base_api_service.dart';
import '../utils/global_exception_handler.dart';

class AuthenticaitonRepository {
  final BaseApiService _apiService;
  AuthenticaitonRepository(this._apiService);

  Future<PanchayatLoginResponse> panchayatLoginUser(
    String username,
    String password,
    int userTypeId,
  ) async {
    try {
      final response = await _apiService.post(
        'Login',
        body: jsonEncode({
          'userName': username,
          'password': password,
          'UserTypeId': userTypeId,
        }),
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
