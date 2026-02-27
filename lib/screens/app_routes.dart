import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/screens/auth/pre_login_screen.dart';
import 'package:jal_sanchalan/screens/ftk_shg/ftk_landingpage.dart';
import 'package:jal_sanchalan/screens/panchayat/VwscListScreen.dart';
import 'package:jal_sanchalan/screens/panchayat/panchayat_landing_screen.dart';
import 'package:jal_sanchalan/screens/panchayat/panchayat_login.dart';
import 'package:jal_sanchalan/screens/vwsc/member_list/members_tab_screen.dart';
import 'package:jal_sanchalan/screens/vwsc/registration_ftk.dart';
import 'package:jal_sanchalan/screens/vwsc/registration_njmp.dart';
import 'package:jal_sanchalan/screens/vwsc/vwsc_dashboard_old.dart';
import 'package:jal_sanchalan/screens/vwsc/vwsc_landing_screen.dart';
import 'package:jal_sanchalan/screens/vwsc/vwsc_login.dart';

import '../utils/app_constants.dart';
import 'auth/splash_screen.dart';
import 'ftk_shg/ftk_questionscategory.dart';
import 'ftk_shg/ftk_shg_login.dart';
import 'ftk_shg/question_cat/basicdetails.dart';
import 'ftk_shg/question_cat/locationform.dart';
import 'ftk_shg/question_cat/monthlychargecollection.dart';
import 'ftk_shg/question_cat/saniSanitaryinspection.dart';
import 'ftk_shg/question_cat/watersampledataform.dart';
import 'njm_wso/njm_wso_landingpage.dart';
import 'njm_wso/njm_wso_login.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      //auth
      AppConstants.navigateToSplashScreen: (context) => const SplashScreen(),
      AppConstants.navigateToPreLoginScreen: (context) => const PreLoginScreen(),

      //panchayat
      AppConstants.navigateToGramPanchayatLogin: (context) => const PanchayatLogin(),
      AppConstants.navigateToPanchayatLandingScreen: (context) => const PanchayatLandingScreen(),
      AppConstants.navigateToVWSCListScreen: (context) => VwscListScreen(),

      //vwsc
      AppConstants.navigateToVWSCDashboard: (context) => const VwscDashboard(),
      AppConstants.navigateToVwscLogin: (context) => const VwscLogin(),
      AppConstants.navigateToVWSCLandingScreen: (context) => const VwscLandingScreen(),
      AppConstants.navigateToNJMPRegistrationForm: (context) => const NJMPRegistrationForm(),
      AppConstants.navigateToSHGFTKRegistrationForm: (context) => const SHGFTKRegistrationForm(),


      //ftk/sgh
      AppConstants.navigateToFTKLogin: (context) => FtkShgLogin(),
      AppConstants.navigateToFtkLandingpage: (context) => FtkLandingpage(),
      AppConstants.navigateToFTKListScrenn: (context) => MembersTabScreen(),
      AppConstants.navigateToFTKQuestionscategory: (context) => FtkQuestionscategory(),
      AppConstants.navigateToBasicDetailsForm: (context) => Basicdetails(),
      AppConstants.navigateToLocationFormScreen: (context) => LocationFormScreen(),
      AppConstants.navigateToWaterSampleForm: (context) => WaterSampleForm(),
      AppConstants.navigateToSanitaryInspectionForm: (context) => SanitaryInspectionForm(),
      AppConstants.navigateToMonthlyChargeCollectionForm: (context) => MonthlyChargeCollectionForm(),


      // njm/wso
      AppConstants.navigateToNJMLogin: (context) => NjmWsoLogin(),
      AppConstants.navigateToNJMWSOLandingPage: (context) => NjmWsoLandingpage(),

    };
  }
}
