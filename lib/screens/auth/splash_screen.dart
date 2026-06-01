import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication_provider.dart';
import '../../providers/update_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/auth/user_session_manager.dart';
import '../../utils/update_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
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

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await session.init();
      await _checkForUpdateAndNavigate();
    });
  }

  Future<void> _checkForUpdateAndNavigate() async {
/*    // Use Provider instance instead of creating new one
    final updateViewModel = Provider.of<UpdateViewModel>(
      context,
      listen: false,
    );

    // Use throttled check (force on startup to ensure first check happens)
    bool isAvailable = await updateViewModel.checkForUpdateWithThrottle(
      forceCheck: true,
    );

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
    await Future.delayed(const Duration(seconds: 2));

    final authProvider = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );

    await authProvider.checkLoginStatus();

    final isLoggedIn = authProvider.isLoggedIn;

    if (!mounted) return;

    if (!isLoggedIn) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppConstants.navigateToPreLoginScreen,
        (route) => false,
      );
      return;
    }

    // 🔥 Read saved user type
    final userTypeId =
        session.userTypeId; // Make sure session.init() loads this

    switch (userTypeId) {
      case 10001: // Panchayat
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppConstants.navigateToPanchayatLandingScreen,
          (route) => false,
        );
        break;

      case 45: // NJM
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppConstants.navigateToWSOLandingPage,
          (route) => false,
        );
        break;

      case 46: // FTK
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppConstants.navigateToSSGLandingpage,
          (route) => false,
        );
        break;

      case 10: // VWSC
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppConstants.navigateToVWSCLandingScreen,
          (route) => false,
        );
        break;

      default:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppConstants.navigateToPreLoginScreen,
          (route) => false,
        );
    }
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/splashscreen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(color: Colors.black.withOpacity(0.45)),

          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [const SizedBox(height: 40)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
