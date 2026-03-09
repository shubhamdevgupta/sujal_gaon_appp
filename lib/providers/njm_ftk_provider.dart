import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/repository/njm_ftk_repository.dart';

import '../models/njm_ftk_response/habitation_assest.dart';
import '../models/njm_ftk_response/njm_ftk_dashboard_response.dart';
import '../models/njm_ftk_response/njm_ftk_login_response.dart';
import '../models/njm_ftk_response/password_login.dart';
import '../models/update_password.dart';
import '../service/local_storage_service.dart';
import '../utils/app_constants.dart';
import '../utils/auth/user_session_manager.dart';
import '../utils/device_utils.dart';
import '../utils/global_exception_handler.dart';

class NjmFtkProvider extends ChangeNotifier {
  final NjmFtkRepository _njmFtkRepository = NjmFtkRepository();
  final LocalStorageService _localStorage = LocalStorageService();
  final session = UserSessionManager();

  String? _deviceId;

  String? get deviceId => _deviceId;

  bool _isShownPassword = false;
  bool get isShownPassword => _isShownPassword;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> fetchDeviceId() async {
    _deviceId = await DeviceInfoUtil.getUniqueDeviceId();
    debugPrint('Device ID: $_deviceId');
    notifyListeners();
  }

  NjmFtkLoginResponse? _njmFtkLoginResponse;

  NjmFtkLoginResponse? get njmFtkLoginResponse => _njmFtkLoginResponse;

  PasswordLoginResponse? _passwordLoginResponse;

  PasswordLoginResponse? get passwordLoginResponse => _passwordLoginResponse;

  NjmFtkDashboardResponse? _njmFtkDashboardResponse;

  NjmFtkDashboardResponse? get njmFtkDashboardResponse =>
      _njmFtkDashboardResponse;

  UpdateNjmFtkPassword? _updateNjmFtkPassword;
  UpdateNjmFtkPassword? get updateNjmFtkPassword => _updateNjmFtkPassword;

  HabitationAssetResponse? _habitationAssetResponse;
  HabitationAssetResponse? get habitationAssetResponse => _habitationAssetResponse;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _generatedOtp;

  String? get generatedOtp => _generatedOtp;

  int? selectedHabitationId;
  int? get habitationId => selectedHabitationId;

  String? errorMsg = '';

  Future<void> loginNjmFtkUserByOtp(
    mobileNumber,
    userTypeId,
    Function() onSuccess,
    Function onFailure,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      _njmFtkLoginResponse = await _njmFtkRepository.loginNjmFtkUserByOtp(
        mobileNumber,
        userTypeId,
      );
      if (_njmFtkLoginResponse?.status == true) {
        await _localStorage.clearAll();
        await _localStorage.saveBool(AppConstants.prefIsLoggedIn, true);

        _generatedOtp = _njmFtkLoginResponse?.otp.toString();

        _localStorage.saveInt(AppConstants.prefUserTypeId, userTypeId);
        _localStorage.saveString(
          AppConstants.prefUserName,
          _njmFtkLoginResponse!.name!,
        );
        _localStorage.saveString(
          AppConstants.prefUserEmail,
          _njmFtkLoginResponse!.email!,
        );
        _localStorage.saveInt(
          AppConstants.prefIsPassUpdated,
          _njmFtkLoginResponse!.isPwdUpdate!,
        );
        _localStorage.saveInt(
          AppConstants.prefUserId,
          _njmFtkLoginResponse!.userId!,
        );
        await session.init();
        onSuccess();
      } else {
        errorMsg = _njmFtkLoginResponse?.message;
        onFailure(errorMsg);
      }
    } catch (e, stackTrace) {
      debugPrint("---- $e >>> $stackTrace");

      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      _njmFtkLoginResponse = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginNjmFtkUserByPassword(
    String mobileNumber,
    String password,
    int userTypeId,
    Function() onSuccess,
    Function onFailure,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      _passwordLoginResponse = await _njmFtkRepository
          .loginNjmFtkUserByPassword(
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

  Future<void> fetchNjmFtkDashboard(int userID, int userTypeID) async {
    _isLoading = true;
    notifyListeners();

    try {
      var rawResponse = await _njmFtkRepository.fetchNjmFtkDashboard(
        userID,
        userTypeID,
      );
      if (rawResponse.status == true) {
        _njmFtkDashboardResponse = rawResponse;

        _localStorage.saveString(
          AppConstants.prefToken,
          _njmFtkDashboardResponse!.token!,
        );

        _localStorage.saveInt(
          AppConstants.prefStateId,
          _njmFtkDashboardResponse!.stateId!,
        );
        _localStorage.saveString(
          AppConstants.prefStateName,
          _njmFtkDashboardResponse!.stateName!,
        );
        _localStorage.saveInt(
          AppConstants.prefDistrictId,
          _njmFtkDashboardResponse!.districtid!,
        );
        _localStorage.saveString(
          AppConstants.prefDistrictName,
          _njmFtkDashboardResponse!.districtName!,
        );
        _localStorage.saveInt(
          AppConstants.prefBlockId,
          _njmFtkDashboardResponse!.blockId!,
        );
        _localStorage.saveString(
          AppConstants.prefBlockName,
          _njmFtkDashboardResponse!.blockName!,
        );
        _localStorage.saveInt(
          AppConstants.prefPanchayatId,
          _njmFtkDashboardResponse!.panchayatId!,
        );
        _localStorage.saveString(
          AppConstants.prefPanchayatName,
          _njmFtkDashboardResponse!.panchayatName!,
        );
      } else {
        errorMsg = rawResponse.msg;
      }
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      _njmFtkLoginResponse = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchHabitationAssetsID(
    int stateID,
    int habitationId,
    int userId,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      var rawResponse = await _njmFtkRepository.fetchHabitationAssetsID(stateID, habitationId, userId,);
      if (rawResponse.status == true) {
        _habitationAssetResponse = rawResponse;
      } else {
        errorMsg = rawResponse.msg;
      }
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      _habitationAssetResponse = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateNjmFtkPasswords(
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
      var rawResponse = await _njmFtkRepository.updateNjmFtkPassword(
        regId,
        userTypeId,
        mobileNumber,
        loginId,
        password,
        createdBy,
        ipAddress,
      );
      if (rawResponse.status == true) {
        _updateNjmFtkPassword = rawResponse;
        await _localStorage.saveInt(
          AppConstants.prefUserId,
          _updateNjmFtkPassword!.userId!,
        );
      } else {
        errorMsg = rawResponse.message;
      }
    } catch (e, stackTrace) {
      debugPrint("**** $e ***$stackTrace");
      _updateNjmFtkPassword = null;
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

  void setSelectedHabitationId(int? value) {
    selectedHabitationId = value;
    notifyListeners();
  }
}
