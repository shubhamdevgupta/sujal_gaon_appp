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
  final AuthenticaitonRepository _authRepository = AuthenticaitonRepository();
  final LocalStorageService _localStorage = LocalStorageService();
  final session = UserSessionManager();

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  var randomOne = 0, randomTwo = 0, captchResult = 0;

  PanchayatLoginResponse? _loginResponse;

  PanchayatLoginResponse? get loginResponse => _loginResponse;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isShownPassword = false;
  bool get isShownPassword => _isShownPassword;

  String? errorMsg = '';

/*
  Future<void> checkLoginStatus() async {
    _isLoggedIn = _localStorage.getBool(AppConstants.prefIsLoggedIn) ?? false;
    notifyListeners();
  }
*/

/*
  Future<void> logoutUser() async {
    _isLoggedIn = false;

    // Clear SharedPreferences
    await _localStorage.clearAll();
    await session.clearPref();
    notifyListeners();
  }
*/

  // Method to login user
  Future<void> loginUser(
    userName,
    password,
    userTypeId,
    Function() onSuccess,
    Function onFailure,
  ) async {
    _isLoading = true;
    notifyListeners();
    String hashPass = generatePasswordHash(password);

    try {
      _loginResponse = await _authRepository.loginUser(
        userName,
        hashPass,
        userTypeId,
      );
      if (_loginResponse?.status == true) {
        onSuccess();
        _localStorage.saveString(
          AppConstants.prefToken,
          _loginResponse!.token.toString(),
        );
        _localStorage.saveInt(
          AppConstants.prefUserId,
          _loginResponse!.userId ?? 0,
        );
      } else {
        errorMsg = _loginResponse?.message;
        onFailure(errorMsg);
      }
    } catch (e, stackTrace) {
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

  String trim(String value) => value.trim();

  String sha512Base64(String input) {
    final List<int> bytes = utf8.encode(input);
    final Digest sha512Hash = sha512.convert(bytes);
    return base64Encode(sha512Hash.bytes);
  }

  String encryptPassword(String password, String salt) {
    String hash1 = sha512Base64(trim(password));
    String hash2 = sha512Base64(salt + hash1);
    return hash2;
  }

  String generatePasswordHash(String password) {
    final passwordBytes = utf8.encode(password);
    final md5Hash = md5.convert(passwordBytes).toString();
    final sha256Hash = sha256.convert(utf8.encode(md5Hash)).toString();

    return sha256Hash;
  }

  /*  int generateCaptcha() {
    int max = 15;
    randomOne = Random().nextInt(max);
    randomTwo = Random().nextInt(max);
    captchResult = randomOne + randomTwo;
    notifyListeners();
    return captchResult;
  }*/

  void togglePasswordVisibility() {
    _isShownPassword = !_isShownPassword;
    notifyListeners();
  }
}
