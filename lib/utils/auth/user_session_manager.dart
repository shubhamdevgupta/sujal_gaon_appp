import '../app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSessionManager {
  static final UserSessionManager _instance = UserSessionManager._internal();

  factory UserSessionManager() => _instance;

  UserSessionManager._internal();

  SharedPreferences? _prefs;

  // Session variables
  String token = '';
  String userName = '';
  String mobile = '';
  String loginId = '';
  int userId = 0;
  int regId = 0;



  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    token = _prefs?.getString(AppConstants.prefToken) ?? '';
    userId = _prefs!.getInt(AppConstants.prefUserId)??0 ;
    regId = _prefs!.getInt(AppConstants.prefRegId)??0 ;
  }

  bool get isInitialized => _prefs != null;

  Future<void> clearPref() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.remove(AppConstants.prefUserId);
    await _prefs!.remove(AppConstants.prefToken);
    await _prefs!.clear(); // Optionally clear all
  }

/*  Future<void> sanitizePrefs() async {
    _prefs ??= await SharedPreferences.getInstance();

    // Check for corrupt data and remove it
    if (_prefs!.get(AppConstants.prefRegId) is String) {
      await _prefs!.remove(AppConstants.prefRegId);
    }

    if (_prefs!.get(AppConstants.prefRoleId) is String) {
      await _prefs!.remove(AppConstants.prefRoleId);
    }

    if (_prefs!.get(AppConstants.prefStateId) is String) {
      await _prefs!.remove(AppConstants.prefStateId);
    }
    if (_prefs!.get(AppConstants.prefDistrictId) is String) {
      await _prefs!.remove(AppConstants.prefDistrictId);
    }

  }*/

}
