import 'dart:convert';

import 'package:jal_sanchalan/models/njm_ftk_dashboard_response.dart';
import 'package:jal_sanchalan/models/njm_ftk_login_response.dart';

import '../models/panchayat/panchayat_login_response.dart';
import '../service/base_api_service.dart';
import '../utils/global_exception_handler.dart';

class AuthenticaitonRepository {
  final BaseApiService _apiService = BaseApiService();

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

  Future<NjmFtkLoginResponse> loginNjmFtkUser(
    String loginId,
    int userTypeId,
  ) async {
    try {
      final response = await _apiService.post(
        'SJL_SendOTP',
        body: jsonEncode({
          'LoginId': loginId,
          'UserTypeId': userTypeId,
        }),
      );

      return NjmFtkLoginResponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<NjmFtkDashboardResponse> fetchNjmFtkDashboard(
    int regId,
  ) async {
    try {
      final response = await _apiService.get(
        'SJL_Get_dashboard_list?RegId=$regId',
      );

      return NjmFtkDashboardResponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
