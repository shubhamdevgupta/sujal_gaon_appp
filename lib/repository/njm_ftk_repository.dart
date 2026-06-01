import 'dart:convert';

import '../models/njm_ftk_response/wso_ssg_dashboard_response.dart';
import '../models/njm_ftk_response/wso_ssg_login_response.dart';
import '../models/njm_ftk_response/password_login.dart';
import '../models/update_password.dart';
import '../service/base_api_service.dart';
import '../utils/global_exception_handler.dart';

class WsoSSGRepository {
  final BaseApiService _apiService;
  WsoSSGRepository(this._apiService);

  Future<PasswordLoginResponse> loginWsoSSGUserByPassword(
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

  Future<WsoSSGLoginResponse> loginWsoSSGUserByOtp(
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

      return WsoSSGLoginResponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<WsoSSGDashboardResponse> fetchWsoSSGDashboard(
    int userId,
    int userTypeId,
  ) async {
    try {
      final response = await _apiService.get(
        'SJL_Get_dashboard_list?UserId=$userId&UserTypeId=$userTypeId',
      );

      return WsoSSGDashboardResponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<UpdateWsoSSGPassword> updateWsoSSGPassword(
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

      return UpdateWsoSSGPassword.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
