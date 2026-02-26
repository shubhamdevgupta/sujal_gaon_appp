import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/screens/njm_wso/landingpage.dart';
import 'package:jal_sanchalan/screens/panchayat/VwscListScreen.dart';
import 'package:jal_sanchalan/screens/panchayat/panchayat_login.dart';
import 'package:jal_sanchalan/screens/panchayat/panchayat_landing_screen.dart';

import 'package:jal_sanchalan/screens/panchayat/vwsc_registration.dart';
import 'package:jal_sanchalan/screens/auth/pre_login_screen.dart';
import 'package:jal_sanchalan/screens/vwsc/njm_wso_registration.dart';
import 'package:jal_sanchalan/screens/vwsc/njmwsoListScreen.dart';
import 'package:jal_sanchalan/screens/vwsc/vwsc_dashboard.dart';
import 'package:jal_sanchalan/screens/vwsc/vwsc_landing_screen.dart';
import 'package:jal_sanchalan/screens/vwsc/vwsc_login.dart';

import '../utils/app_constants.dart';
import 'auth/login_screen.dart';
import 'auth/splash_screen.dart';
import 'njm_wso/njm_login.dart';
import 'njm_wso/njm_questionscategory.dart';
import 'njm_wso/question_cat/basicdetails.dart';
import 'njm_wso/question_cat/locationform.dart';
import 'njm_wso/question_cat/watersampledataform.dart';
import 'panchayat/dashboard.dart';
import 'panchayat/panchayat_dashboard.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      //auth
      AppConstants.navigateToDashboardScreen: (context) =>
          const DashboardScreen(),
      AppConstants.navigateToLoginScreen: (context) => const Loginscreen(),
      AppConstants.navigateToSplashScreen: (context) => const SplashScreen(),
      AppConstants.navigateToGramPanchayatLogin: (context) => const PanchayatLogin(),
      AppConstants.navigateToPanchayatDashboard: (context) => const PanchayatDashboard(),
      AppConstants.navigateToVWSCDashboard: (context) => const VwscDashboard(),
      AppConstants.navigateToPanchayatLandingScreen: (context) => const PanchayatLandingScreen(),
      AppConstants.navigateToVwscLogin: (context) => const VwscLogin(),
      AppConstants.navigateToVWSCLandingScreen: (context) => const VwscLandingScreen(),

      AppConstants.navigateToRegisterVwscScreen: (context) => const RegisterVwscScreen(),
      AppConstants.navigateToRegisterNJMWSOScreen: (context) => const NjmWsoRegistration(),
      AppConstants.navigateToVWSCListScreen: (context) =>  VwscListScreen(),
      AppConstants.navigateToNjmLogin: (context) =>  NjmLogin(),
      AppConstants.navigateToNJMListScrenn: (context) =>  Njmwsolistscreen(),
      AppConstants.navigateToNJMLandingScreen: (context) =>  NjmLandingScreen(),
      AppConstants.navigateToNjmQuestionscategory: (context) =>  NjmQuestionscategory(),
      AppConstants.navigateToBasicDetailsForm: (context) =>  BasicDetailsForm(),
      AppConstants.navigateToLocationFormScreen: (context) =>  LocationFormScreen(),
      AppConstants.navigateToWaterSampleForm: (context) =>  WaterSampleForm(),
      AppConstants.navigateToPreLoginScreen: (context) => const PreLoginScreen(),



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
