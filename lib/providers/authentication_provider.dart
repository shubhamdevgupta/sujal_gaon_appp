import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../models/login_response.dart';
import '../repository/authentication_repository.dart';
import '../service/local_storage_service.dart';
import '../utils/app_constants.dart';
import '../utils/auth/user_session_manager.dart';
import '../utils/global_exception_handler.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticaitonRepository _authRepository = AuthenticaitonRepository();
  final LocalStorageService _localStorage = LocalStorageService();
  final session = UserSessionManager();

  AuthenticationProvider() {
    generateCaptcha();
  }

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  var randomOne = 0, randomTwo = 0, captchResult = 0;

  LoginResponseModel? _loginResponse;
  bool _isLoading = false;

  // Getters
  LoginResponseModel? get loginResponse => _loginResponse;

  bool get isLoading => _isLoading;

  bool _isShownPassword = false;

  bool get isShownPassword => _isShownPassword;

  String errorMsg = '';

  double? _currentLatitude;
  double? _currentLongitude;

  double? get currentLatitude => _currentLatitude;

  double? get currentLongitude => _currentLongitude;

  Future<void> checkLoginStatus() async {
    _isLoggedIn = _localStorage.getBool(AppConstants.prefIsLoggedIn) ?? false;
    notifyListeners();
  }

  Future<void> logoutUser() async {
    _isLoggedIn = false;

    // Clear SharedPreferences
    await _localStorage.clearAll();
    await session.clearPref();
    notifyListeners();
  }

  // Method to login user
  Future<void> loginUser(
    userName,
    password,
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
        "DWS_WS",
      );
      if (_loginResponse?.msgCode == 200) {
        onSuccess();
        generateCaptcha();
      } else {
        errorMsg = _loginResponse!.msg!;
        onFailure(errorMsg);
      }
    } catch (e, stackTrace) {
      print("exception in auth provider--->>>  $e");
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

  /*
  Future<void> fetchLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('Requesting location permission...');
      bool permissionGranted = await LocationUtils.requestLocationPermission();

      if (permissionGranted) {
        debugPrint('Permission granted. Fetching location...');
        final locationData = await LocationUtils.getCurrentLocation();

        if (locationData != null) {
          _currentLatitude = locationData['latitude'];
          _currentLongitude = locationData['longitude'];

          // 🔥 Set global current location
          CurrentLocation.setLocation(
            lat: _currentLatitude!,
            lng: _currentLongitude!,
          );

          debugPrint(
            'Location Fetched: Lat: $_currentLatitude, Lng: $_currentLongitude',
          );
        } else {
          debugPrint("Location fetch failed (locationData is null)");
        }
      } else {
        debugPrint("Permission denied. Cannot fetch location.");
      }
    } catch (e) {
      debugPrint("Error during fetchLocation(): $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
*/

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

  /// Generates a random salt of the given length
  String generateSalt({int length = 16}) {
    final Random random = Random.secure();
    final List<int> saltBytes = List<int>.generate(
      length,
      (_) => random.nextInt(256),
    );
    return base64Encode(saltBytes);
  }

  String generatePasswordHash(String password) {
    // Step 1: Convert password to bytes
    final passwordBytes = utf8.encode(password);

    // Step 2: MD5 hash
    final md5Hash = md5.convert(passwordBytes).toString();

    // Step 3: SHA256 of MD5 result
    final sha256Hash = sha256.convert(utf8.encode(md5Hash)).toString();

    return sha256Hash;
  }

  int generateCaptcha() {
    int max = 15;
    randomOne = Random().nextInt(max);
    randomTwo = Random().nextInt(max);
    captchResult = randomOne + randomTwo;
    notifyListeners();
    return captchResult;
  }

  // Toggle Password Visibility
  void togglePasswordVisibility() {
    _isShownPassword = !_isShownPassword;
    notifyListeners();
  }
}
