import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/screens/Dashboard.dart';
import 'package:jal_sanchalan/screens/landing_screen.dart';
import 'package:jal_sanchalan/screens/vwsc_registration.dart';


import '../screens/gp_login.dart';
import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';
import 'app_constants.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      //auth
      AppConstants.navigateToDashboardScreen: (context) => const DashboardScreen(),
      AppConstants.navigateToLoginScreen: (context) => const Loginscreen(),
      AppConstants.navigateToSplashScreen: (context) => const SplashScreen(),
      AppConstants.navigateToGpLogin: (context) => const GpLoginDashboardScreen(),
      AppConstants.navigateToLandingScreen: (context) => const LandingScreen(),
      AppConstants.navigateToRegisterVwscScreen: (context) => const RegisterVwscScreen(),

 /*     //dwsmList
      AppConstants.navigateToDemonstrationScreen: (context) =>
          const Demonstrationscreen(type: 0),
      AppConstants.navigateToSchoolAwsScreen: (context) =>
          const SchoolAWCScreen(type: 0),
      //tabschoolaganwadi
      AppConstants.navigateToAnganwadiScreen: (context) => const AnganwadiScreen(),
      AppConstants.navigateToSchoolScreen: (context) => const SchoolScreen(),
      AppConstants.navigateToTabSchoolAganwadi: (context) =>
          const Tabschoolaganwadi(),
      //dwsm
      AppConstants.navigateToDwsmDashboard: (context) => const Dwsdashboardscreen(),
      AppConstants.navigateToDwsmLocaitonScreen: (context) => const DwsmLocation(),
      //lab
      AppConstants.navigateLabView: (context) => const AsPerLabTabView(),
      AppConstants.navigateToParameterView: (context) => const Asperparameterview(),
      AppConstants.navigateToLabParam: (context) => const Labparameterscreen(),
      AppConstants.navigateToWTPLab: (context) => const Wtplabscreen(),


      //ftk
      AppConstants.navigateToFtkSampleScreen: (context) => const Ftkmenudashboardscreen(),
      AppConstants.navigateToFtkDashboard: (context) => const ftkDashboard(),
      AppConstants.navigateToFtkSampleListScreen:(context)=> const FtkSampleListScreen(),
      //webview
      AppConstants.navigateToTestReport: (context) => const TestReport(
            url: '',
          ),

      AppConstants.navigateToExceptionScreen: (context) =>
          const ExceptionScreen(errorMessage: '',errorCode: "",),
      AppConstants.navigateToLocationScreen: (context) =>
           const Locationscreen(flag: '',flagFloating: '',),
      AppConstants.navigateToSampleInformationScreen: (context) =>
          const Sampleinformationscreen(),
      AppConstants.navigateToSampleListScreen: (context) => const SampleListScreen(),
      AppConstants.navigateToSubmitSampleScreen: (context) =>
          const SubmitSampleScreen(),
      AppConstants.navigateToftkSampleInfoScreen: (context) => const ftkSampleInformationScreen(),*/
    };
  }
}
