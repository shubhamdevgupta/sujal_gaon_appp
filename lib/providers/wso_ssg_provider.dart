import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

import '../models/njm_ftk_response/wso_ssg_dashboard_response.dart';
import '../models/njm_ftk_response/wso_ssg_login_response.dart';
import '../models/njm_ftk_response/password_login.dart';
import '../models/update_password.dart';
import '../repository/njm_ftk_repository.dart';
import '../service/local_storage_service.dart';
import '../utils/app_constants.dart';
import '../utils/auth/user_session_manager.dart';
import '../utils/global_exception_handler.dart';

class WsoSSGProvider extends ChangeNotifier {
  final WsoSSGRepository _wsoSSGRepository;
  WsoSSGProvider(this._wsoSSGRepository);

  final LocalStorageService _localStorage = LocalStorageService();
  final session = UserSessionManager();

  bool _isShownPassword = false;

  bool get isShownPassword => _isShownPassword;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  WsoSSGLoginResponse? _wsoSSGLoginResponse;

  WsoSSGLoginResponse? get wsoSSGLoginResponse => _wsoSSGLoginResponse;

  PasswordLoginResponse? _passwordLoginResponse;

  PasswordLoginResponse? get passwordLoginResponse => _passwordLoginResponse;

  WsoSSGDashboardResponse? _wsoSSGDashboardResponse;

  WsoSSGDashboardResponse? get wsoSSGDashboardResponse =>
      _wsoSSGDashboardResponse;

  UpdateWsoSSGPassword? _updateWsoSSGPassword;

  UpdateWsoSSGPassword? get updateWsoSSGPassword => _updateWsoSSGPassword;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _generatedOtp;

  String? get generatedOtp => _generatedOtp;

  String? errorMsg = '';

  Future<void> loginWsoSSGUserByOtp(
    mobileNumber,
    userTypeId,
    Function() onSuccess,
    Function onFailure,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      _wsoSSGLoginResponse = await _wsoSSGRepository.loginWsoSSGUserByOtp(
        mobileNumber,
        userTypeId,
      );
      if (_wsoSSGLoginResponse?.status == true) {
        await _localStorage.clearAll();
        await _localStorage.saveBool(AppConstants.prefIsLoggedIn, true);

        _generatedOtp = _wsoSSGLoginResponse?.otp.toString();

        _localStorage.saveInt(AppConstants.prefUserTypeId, userTypeId);
        _localStorage.saveString(
          AppConstants.prefUserName,
          _wsoSSGLoginResponse!.name!,
        );
        _localStorage.saveString(
          AppConstants.prefUserEmail,
          _wsoSSGLoginResponse!.email!,
        );
        _localStorage.saveInt(
          AppConstants.prefIsPassUpdated,
          _wsoSSGLoginResponse!.isPwdUpdate!,
        );
        _localStorage.saveInt(
          AppConstants.prefUserId,
          _wsoSSGLoginResponse!.userId!,
        );
        await session.init();
        onSuccess();
      } else {
        errorMsg = _wsoSSGLoginResponse?.message;
        onFailure(errorMsg);
      }
    } catch (e, stackTrace) {
      debugPrint("---- $e >>> $stackTrace");

      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      _wsoSSGLoginResponse = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginWsoSSGUserByPassword(
    String mobileNumber,
    String password,
    int userTypeId,
    Function() onSuccess,
    Function onFailure,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      _passwordLoginResponse = await _wsoSSGRepository
          .loginWsoSSGUserByPassword(
            mobileNumber,
            generateSha512Pass(password),
            userTypeId,
          );
      if (_passwordLoginResponse?.status == true) {
        await _localStorage.clearAll();
        await _localStorage.saveBool(AppConstants.prefIsLoggedIn, true);
        _localStorage.saveInt(AppConstants.prefUserTypeId, userTypeId);
        _localStorage.saveInt(
          AppConstants.prefUserId,
          _passwordLoginResponse!.userId!,
        );
        _localStorage.saveInt(
          AppConstants.prefIsPassUpdated,
          _passwordLoginResponse!.isPwdUpdated ?? 0,
        );
        debugPrint("!!!!!  ${_passwordLoginResponse!.isPwdUpdated}");
        await session.init();
        onSuccess();
      } else {
        errorMsg = _passwordLoginResponse?.message;
        onFailure(errorMsg);
      }
    } catch (e, stackTrace) {
      debugPrint("---- $e >>> $stackTrace");

      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      _passwordLoginResponse = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWsoSSGDashboard(int userID, int userTypeID) async {
    _isLoading = true;
    notifyListeners();

    try {
      var rawResponse = await _wsoSSGRepository.fetchWsoSSGDashboard(
        userID,
        userTypeID,
      );
      if (rawResponse.status == true) {
        _wsoSSGDashboardResponse = rawResponse;

        _localStorage.saveString(
          AppConstants.prefToken,
          _wsoSSGDashboardResponse!.token!,
        );

        _localStorage.saveInt(
          AppConstants.prefStateId,
          _wsoSSGDashboardResponse!.stateId!,
        );
        _localStorage.saveString(
          AppConstants.prefStateName,
          _wsoSSGDashboardResponse!.stateName!,
        );
        _localStorage.saveInt(
          AppConstants.prefDistrictId,
          _wsoSSGDashboardResponse!.districtid!,
        );
        _localStorage.saveString(
          AppConstants.prefDistrictName,
          _wsoSSGDashboardResponse!.districtName!,
        );
        _localStorage.saveInt(
          AppConstants.prefBlockId,
          _wsoSSGDashboardResponse!.blockId!,
        );
        _localStorage.saveString(
          AppConstants.prefBlockName,
          _wsoSSGDashboardResponse!.blockName!,
        );
        _localStorage.saveInt(
          AppConstants.prefPanchayatId,
          _wsoSSGDashboardResponse!.panchayatId!,
        );
        _localStorage.saveString(
          AppConstants.prefPanchayatName,
          _wsoSSGDashboardResponse!.panchayatName!,
        );
      } else {
        errorMsg = rawResponse.msg;
      }
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      _wsoSSGLoginResponse = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateWsoSSGPasswords(
    int regId,
    int userTypeId,
    String mobileNumber,
    String loginId,
    String password,
    int createdBy,
    String ipAddress,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      var rawResponse = await _wsoSSGRepository.updateWsoSSGPassword(
        regId,
        userTypeId,
        mobileNumber,
        loginId,
        password,
        createdBy,
        ipAddress,
      );
      if (rawResponse.status == true) {
        _updateWsoSSGPassword = rawResponse;
        await _localStorage.saveInt(
          AppConstants.prefUserId,
          _updateWsoSSGPassword!.userId!,
        );
      } else {
        errorMsg = rawResponse.message;
      }
    } catch (e, stackTrace) {
      debugPrint("**** $e ***$stackTrace");
      _updateWsoSSGPassword = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void verifyOtp(
    String enteredOtp,
    Function() onSuccess,
    Function(String) onFailure,
  ) {
    print("-------- ${session.regId}");
    if (_generatedOtp == null) {
      onFailure("Please request OTP first");
      return;
    }

    if (enteredOtp == _generatedOtp) {
      _isLoggedIn = true;
      onSuccess();
    } else {
      onFailure("Invalid OTP");
    }
  }

  String generateSha512Pass(String password) {
    final sha256Hash = sha512.convert(utf8.encode(password)).toString();
    return sha256Hash;
  }

  void togglePasswordVisibility() {
    _isShownPassword = !_isShownPassword;
    notifyListeners();
  }
}
