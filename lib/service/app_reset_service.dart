import 'package:flutter/material.dart';
class AppResetService {
  static Future<void> fullReset(BuildContext context) async {
    /*// 1. Clear Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all stored values
*/
    // 2. Reset All Providers
  ///  Provider.of<AuthenticationProvider>(context, listen: false).logoutUser();
  //  Provider.of<MasterProvider>(context, listen: false).clearData();
    // Add other providers here if needed

    // 3. Navigate to Login or Splash Screen
/*    Navigator.pushNamedAndRemoveUntil(
      context,
      AppConstants.navigateToLoginScreen,
          (route) => false, // Clear entire stack
    );*/
  }
}
