import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jal_sanchalan/providers/master_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/app_constants.dart';
import '../../utils/auth/user_session_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final session = UserSessionManager();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
   //   await session.sanitizePrefs(); // await clear
      await session.init(); // await init after clearing
      await _checkForUpdateAndNavigate(); // navigate after setup
    });
  }

  Future<void> _checkForUpdateAndNavigate() async {
    // Use Provider instance instead of creating new one
    /*    final updateViewModel = Provider.of<UpdateViewModel>(context, listen: false);

    // Use throttled check (force on startup to ensure first check happens)
    bool isAvailable = await updateViewModel.checkForUpdateWithThrottle(forceCheck: true);

    if (isAvailable && mounted) {
      final updateInfo = await updateViewModel.getUpdateInfo();

      if (updateInfo != null && !updateViewModel.isDialogShown) {
        updateViewModel.setDialogShown(true);
        await DialogUtils.showUpdateDialog(context, updateInfo);
        updateViewModel.setDialogShown(false);
        return;
      }
    }*/
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
      await Future.delayed(const Duration(seconds: 3)); // Optional splash delay

    /*  final authProvider = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );*/
    final masterProvider = Provider.of<MasterProvider>(context, listen: false);
    //final roleId = session.roleId;
    //  await authProvider.checkLoginStatus();
    //  masterProvider.clearData();
    /*    if (authProvider.isLoggedIn) {
      if (roleId == 4) {
        Navigator.pushReplacementNamed(
          context,
          AppConstants.navigateToDashboardScreen,
        );
      } else if (roleId == 8) {
        Navigator.pushReplacementNamed(
          context,
          AppConstants.navigateToDwsmDashboard,
        );
      } else if (roleId == 7) {
        Navigator.pushReplacementNamed(
          context,
          AppConstants.navigateToFtkDashboard,
        );
      }
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppConstants.navigateToLoginScreen,
      );
    }*/
       Navigator.pushReplacementNamed(
      context,
      AppConstants.navigateToPreLoginScreen,
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ================= BACKGROUND IMAGE =================
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/splashscreen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ================= DARK OVERLAY =================
          Container(color: Colors.black.withOpacity(0.45)),

          // ================= CONTENT =================
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App Title
        /*          const Text(
                    "Sujal Gaon",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Empowering Rural Water Management",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      letterSpacing: 1,
                    ),
                  ),*/

                  const SizedBox(height: 40),

                  // Loading Indicator
                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
