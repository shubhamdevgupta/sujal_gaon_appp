import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../models/panchayat/panchayat_login_response.dart';
import '../repository/authentication_repository.dart';
import '../service/local_storage_service.dart';
import '../utils/app_constants.dart';
import '../utils/auth/user_session_manager.dart';
import '../utils/global_exception_handler.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticaitonRepository _authRepository;
  AuthenticationProvider(this._authRepository);

  final LocalStorageService _localStorage = LocalStorageService();
  final session = UserSessionManager();

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  var randomOne = 0, randomTwo = 0, captchResult = 0;

  PanchayatLoginResponse? _loginResponse;

  PanchayatLoginResponse? get loginResponse => _loginResponse;

  PanchayatResult? _panchayatResult;

  PanchayatResult? get panchayatResult => _panchayatResult;

  String? _generatedOtp;

  String? get generatedOtp => _generatedOtp;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isShownPassword = false;

  bool get isShownPassword => _isShownPassword;

  String? errorMsg = '';

  // Method to login user
  Future<void> panchayatLoginUser(
    String userName,
    String password,
    int userTypeId,
    Function() onSuccess,
    Function onFailure,
  ) async {
    _isLoading = true;
    notifyListeners();
    String hashPass = generatePasswordHash(password);

    try {
      _loginResponse = await _authRepository.panchayatLoginUser(
        userName,
        hashPass,
        userTypeId,
      );
      if (_loginResponse?.status == true) {
        await _localStorage.clearAll();

        await _localStorage.saveBool(AppConstants.prefIsLoggedIn, true);
        onSuccess();
        _panchayatResult = _loginResponse!.result;
        _localStorage.saveString(
          AppConstants.prefToken,
          _loginResponse!.token.toString(),
        );
        _localStorage.saveString(
          AppConstants.prefStateId,
          _loginResponse!.result!.loginResult!.stateId.toString(),
        );
        _localStorage.saveString(
          AppConstants.prefStateName,
          _loginResponse!.result!.loginResult!.stateName.toString(),
        );
        _localStorage.saveString(
          AppConstants.prefDistrictId,
          _loginResponse!.result!.loginResult!.districtId.toString(),
        );
        _localStorage.saveString(
          AppConstants.prefDistrictName,
          _loginResponse!.result!.loginResult!.districtName.toString(),
        );
        _localStorage.saveString(
          AppConstants.prefBlockId,
          _loginResponse!.result!.loginResult!.blockId.toString(),
        );
        _localStorage.saveString(
          AppConstants.prefBlockName,
          _loginResponse!.result!.loginResult!.blockName.toString(),
        );
        _localStorage.saveString(
          AppConstants.prefPanchayatId,
          _loginResponse!.result!.loginResult!.panchayatId.toString(),
        );
        _localStorage.saveString(
          AppConstants.prefPanchayatName,
          _loginResponse!.result!.loginResult!.panchayatName.toString(),
        );
        _localStorage.saveInt(
          AppConstants.prefUserId,
          _loginResponse!.userId ?? 0,
        );

        _localStorage.saveInt(AppConstants.prefUserTypeId, userTypeId);
        await session.init();
      } else {
        errorMsg = _loginResponse?.message;
        onFailure(errorMsg);
      }
    } catch (e, stackTrace) {
      debugPrint("---- $e >>> $stackTrace");

      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      _loginResponse = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String generatePasswordHash(String password) {
    final passwordBytes = utf8.encode(password);
    final md5Hash = md5.convert(passwordBytes).toString();
    final sha256Hash = sha256.convert(utf8.encode(md5Hash)).toString();

    return sha256Hash;
  }

  Future<void> checkLoginStatus() async {
    _isLoggedIn =
        await _localStorage.getBool(AppConstants.prefIsLoggedIn) ?? false;
    notifyListeners();
  }

  Future<void> logoutUser() async {
    _isLoggedIn = false;

    // Clear SharedPreferences
    await _localStorage.clearAll();
    await session.clearPref();
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isShownPassword = !_isShownPassword;
    notifyListeners();
  }
}
