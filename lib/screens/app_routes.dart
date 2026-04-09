import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/screens/auth/pre_login_screen.dart';
import 'package:jal_sanchalan/screens/ftk_shg/ftk_landingpage.dart';
import 'package:jal_sanchalan/screens/njm_wso/njm_wso_cat/ohsr/overhead_service_regular.dart';
import 'package:jal_sanchalan/screens/panchayat/panchayat_landing_screen.dart';
import 'package:jal_sanchalan/screens/panchayat/panchayat_login.dart';
import 'package:jal_sanchalan/screens/panchayat/vwsc_member_list.dart';
import 'package:jal_sanchalan/screens/vwsc/member_list/members_tab_screen.dart';
import 'package:jal_sanchalan/screens/vwsc/registration_ftk.dart';
import 'package:jal_sanchalan/screens/vwsc/registration_njmp.dart';
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
import 'njm_wso/njm_category_regular.dart';
import 'njm_wso/njm_wso_cat/disinfection_chlorination.dart';
import 'njm_wso/njm_wso_cat/distribution_supply.dart';
import 'njm_wso/njm_wso_cat/escaltion_alters.dart';
import 'njm_wso/njm _category_inventory.dart';
import 'njm_wso/njm_wso_cat/nonsupply_distruptions.dart';
import 'njm_wso/njm_wso_cat/ohsr/overhead_service_main.dart';
import 'njm_wso/njm_wso_cat/water_pump/pumping_main.dart';
import 'njm_wso/njm_wso_cat/water_pump/pumping_regular.dart';
import 'njm_wso/njm_wso_cat/water_source/groundwatersourcetube_main.dart';
import 'njm_wso/njm_wso_cat/water_source/groundwatersourcetube_regular.dart';
import 'njm_wso/njm_wso_cat/wsc_category.dart';
import 'njm_wso/njm_wso_landingpage.dart';
import 'njm_wso/njm_wso_login.dart';
import 'njm_wso/njm_wso_cat/gls_reservoir.dart';
import 'njm_wso/njm_wso_cat/spring_water.dart';


class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      //auth
      AppConstants.navigateToSplashScreen: (context) => const SplashScreen(),
      AppConstants.navigateToPreLoginScreen: (context) =>
          const PreLoginScreen(),

      //panchayat
      AppConstants.navigateToGramPanchayatLogin: (context) =>
          const PanchayatLogin(),
      AppConstants.navigateToPanchayatLandingScreen: (context) =>
          const PanchayatLandingScreen(),
      AppConstants.navigateToVWSCListScreen: (context) => VwscMemberList(),

      //vwsc
      AppConstants.navigateToVwscLogin: (context) => const VwscLogin(),
      AppConstants.navigateToVWSCLandingScreen: (context) =>
          const VwscLandingScreen(),
      AppConstants.navigateToNJMPRegistrationForm: (context) =>
          const NJMPRegistrationForm(),
      AppConstants.navigateToSHGFTKRegistrationForm: (context) =>
          const SHGFTKRegistrationForm(),
      AppConstants.navigateToVWSCMemberScrenn: (context) => MembersTabScreen(),

      //ftk/sgh
      AppConstants.navigateToFTKLogin: (context) => FtkShgLogin(),
      AppConstants.navigateToFtkLandingpage: (context) => FtkLandingpage(),
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

      // njm / wso
      AppConstants.navigateToNJMLogin: (context) => NjmWsoLogin(),
      AppConstants.navigateToNJMWSOLandingPage: (context) =>
          NjmWsoLandingpage(),
      AppConstants.navigateToNjmCategory: (context) => const NjmCategory(),
      AppConstants.navigateToGroundwatersourcetubeMain: (context) => const GroundwatersourcetubeMain(),
      AppConstants.navigateToGroundwatersourcetubeRegular: (context) =>
          const GroundwatersourcetubeRegular(),
      AppConstants.navigateToPumpingMain: (context) => const PumpingMain(),
      AppConstants.navigateToPumpingRegular: (context) => const PumpingRegular(),
      AppConstants.navigateToOHSRMain: (context) => const OhsrMain(),
      AppConstants.navigateToOHSRRegular: (context) => const OhsrRegular(),
      AppConstants.navigateToGSRForm: (context) => const GSRForm(),
      AppConstants.navigateToSpringWaterForm: (context) =>
          const SpringWaterForm(),
      AppConstants.navigateToDistributionSupplyForm: (context) =>
          const DistributionSupplyForm(),
      AppConstants.navigateToDisinfectionForm: (context) =>
          const DisinfectionForm(),
      AppConstants.navigateToNonSupplyForm: (context) => const NonSupplyForm(),
      AppConstants.navigateToEscalationAlertsScreen: (context) =>
          const EscalationAlertsScreen(),
      AppConstants.navigateToNjmRegularEntry: (context) =>
          const NjmRegularEntry(),
    };
  }
}
