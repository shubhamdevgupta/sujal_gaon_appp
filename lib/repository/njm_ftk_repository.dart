import 'dart:convert';

import '../models/njm_ftk_response/njm_ftk_dashboard_response.dart';
import '../models/njm_ftk_response/njm_ftk_login_response.dart';
import '../models/njm_ftk_response/password_login.dart';
import '../models/update_password.dart';
import '../service/base_api_service.dart';
import '../utils/global_exception_handler.dart';

class NjmFtkRepository {
  final BaseApiService _apiService;
  NjmFtkRepository(this._apiService);

  Future<PasswordLoginResponse> loginNjmFtkUserByPassword(
    String username,
    String password,
    int userTypeId,
  ) async {
    try {
      final response = await _apiService.post(
        'NJMPLogin',
        body: jsonEncode({
          'userName': username,
          'password': password,
          'UserTypeId': userTypeId,
        }),
      );

      return PasswordLoginResponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<NjmFtkLoginResponse> loginNjmFtkUserByOtp(
    String mobileNumber,
    int userTypeId,
  ) async {
    try {
      final response = await _apiService.post(
        'SJL_SendOTP',
        body: jsonEncode({
          'MobileNumber': mobileNumber,
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
    int userId,
    int userTypeId,
  ) async {
    try {
      final response = await _apiService.get(
        'SJL_Get_dashboard_list?UserId=$userId&UserTypeId=$userTypeId',
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

  Future<UpdateNjmFtkPassword> updateNjmFtkPassword(
    int regId,
    int userTypeId,
    String mobileNumber,
    String loginId,
    String password,
    int createdBy,
    String ipAddress,
  ) async {
    try {
      final response = await _apiService.post(
        'SJL_GenerateLoginId_password',
        body: jsonEncode({
          'RegId': regId,
          'UserTypeId': userTypeId,
          'MobileNumber': mobileNumber,
          'LoginId': loginId,
          'Sha512Password': password,
          'CreatedBy': createdBy,
          'created_IP': ipAddress,
        }),
      );

      return UpdateNjmFtkPassword.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
