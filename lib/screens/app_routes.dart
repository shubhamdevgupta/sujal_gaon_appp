import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/screens/ftk_shg/ftk_landingpage.dart';
import 'package:jal_sanchalan/screens/panchayat/VwscListScreen.dart';
import 'package:jal_sanchalan/screens/panchayat/panchayat_login.dart';
import 'package:jal_sanchalan/screens/panchayat/panchayat_landing_screen.dart';

import 'package:jal_sanchalan/screens/panchayat/vwsc_registration.dart';
import 'package:jal_sanchalan/screens/auth/pre_login_screen.dart';
import 'package:jal_sanchalan/screens/vwsc/registration_ftk.dart';
import 'package:jal_sanchalan/screens/vwsc/registration_njmp.dart';
import 'package:jal_sanchalan/screens/vwsc/list_ftk_sgh.dart';
import 'package:jal_sanchalan/screens/vwsc/vwsc_dashboard.dart';
import 'package:jal_sanchalan/screens/vwsc/vwsc_landing_screen.dart';
import 'package:jal_sanchalan/screens/vwsc/vwsc_login.dart';

import '../utils/app_constants.dart';
import 'auth/login_screen.dart';
import 'auth/splash_screen.dart';
import 'ftk_shg/ftk_questionscategory.dart';
import 'ftk_shg/ftk_shg_login.dart';
import 'ftk_shg/question_cat/basicdetails.dart';
import 'ftk_shg/question_cat/locationform.dart';
import 'ftk_shg/question_cat/monthlychargecollection.dart';
import 'ftk_shg/question_cat/saniSanitaryinspection.dart';
import 'ftk_shg/question_cat/watersampledataform.dart';
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
      AppConstants.navigateToGramPanchayatLogin: (context) =>
          const PanchayatLogin(),
      AppConstants.navigateToPanchayatDashboard: (context) =>
          const PanchayatDashboard(),
      AppConstants.navigateToVWSCDashboard: (context) => const VwscDashboard(),
      AppConstants.navigateToPanchayatLandingScreen: (context) =>
          const PanchayatLandingScreen(),
      AppConstants.navigateToVwscLogin: (context) => const VwscLogin(),
      AppConstants.navigateToVWSCLandingScreen: (context) =>
          const VwscLandingScreen(),

      AppConstants.navigateToRegisterVwscScreen: (context) =>
          const RegisterVwscScreen(),
      AppConstants.navigateToNJMPRegistrationForm: (context) =>
          const NJMPRegistrationForm(),
      AppConstants.navigateToSHGFTKRegistrationForm: (context) =>
          const SHGFTKRegistrationForm(),
      AppConstants.navigateToVWSCListScreen: (context) => VwscListScreen(),
      AppConstants.navigateToFTKLogin: (context) => FtkShgLogin(),
      AppConstants.navigateToFtkLandingpage: (context) => FtkLandingpage(),
      AppConstants.navigateToFTKListScrenn: (context) => ListFtkSgh(),
      AppConstants.navigateToFTKQuestionscategory: (context) =>
          FtkQuestionscategory(),
      AppConstants.navigateToBasicDetailsForm: (context) => Basicdetails(),
      AppConstants.navigateToLocationFormScreen: (context) =>
          LocationFormScreen(),
      AppConstants.navigateToWaterSampleForm: (context) => WaterSampleForm(),
      AppConstants.navigateToSanitaryInspectionForm: (context) =>
          SanitaryInspectionForm(),
      AppConstants.navigateToMonthlyChargeCollectionForm: (context) =>
          MonthlyChargeCollectionForm(),
      AppConstants.navigateToPreLoginScreen: (context) =>
          const PreLoginScreen(),

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
