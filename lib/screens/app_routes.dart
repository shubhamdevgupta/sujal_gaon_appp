import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/screens/auth/pre_login_screen.dart';
import 'package:jal_sanchalan/screens/ftk_shg/ftk_landingpage.dart';
import 'package:jal_sanchalan/screens/panchayat/vwsc_member_list.dart';
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
import 'njm_wso/njm_wso_cat/disinfection_chlorination.dart';
import 'njm_wso/njm_wso_cat/distribution_supply.dart';
import 'njm_wso/njm_wso_cat/escaltion_alters.dart';
import 'njm_wso/njm_wso_cat/njm _category.dart';
import 'njm_wso/njm_wso_cat/nonsupply_distruptions.dart';
import 'njm_wso/njm_wso_cat/water_supply_components/gls_reservoir.dart';
import 'njm_wso/njm_wso_cat/water_supply_components/groundwatersourcetube_form.dart';
import 'njm_wso/njm_wso_cat/water_supply_components/wsc_category.dart';
import 'njm_wso/njm_wso_cat/water_supply_components/overhead_service.dart';
import 'njm_wso/njm_wso_cat/water_supply_components/pumps_form.dart';
import 'njm_wso/njm_wso_cat/water_supply_components/spring_water.dart';
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
      AppConstants.navigateToVWSCListScreen: (context) => VwscMemberList(),

      //vwsc
      AppConstants.navigateToVwscLogin: (context) => const VwscLogin(),
      AppConstants.navigateToVWSCLandingScreen: (context) => const VwscLandingScreen(),
      AppConstants.navigateToNJMPRegistrationForm: (context) => const NJMPRegistrationForm(),
      AppConstants.navigateToSHGFTKRegistrationForm: (context) => const SHGFTKRegistrationForm(),
      AppConstants.navigateToVWSCMemberScrenn: (context) => MembersTabScreen(),


      //ftk/sgh
      AppConstants.navigateToFTKLogin: (context) => FtkShgLogin(),
      AppConstants.navigateToFtkLandingpage: (context) => FtkLandingpage(),
      AppConstants.navigateToFTKQuestionscategory: (context) => FtkQuestionscategory(),
      AppConstants.navigateToBasicDetailsForm: (context) => Basicdetails(),
      AppConstants.navigateToLocationFormScreen: (context) => LocationFormScreen(),
      AppConstants.navigateToWaterSampleForm: (context) => WaterSampleForm(),
      AppConstants.navigateToSanitaryInspectionForm: (context) => SanitaryInspectionForm(),
      AppConstants.navigateToMonthlyChargeCollectionForm: (context) => MonthlyChargeCollectionForm(),

      // njm / wso
      AppConstants.navigateToNJMLogin: (context) => NjmWsoLogin(),
      AppConstants.navigateToNJMWSOLandingPage: (context) => NjmWsoLandingpage(),
      AppConstants.navigateToNjmCategory: (context) => const NjmCategory(),
      AppConstants.navigateToWscCategory: (context) => const WscCategory(),
      AppConstants.navigateToGroundWaterPumpForm: (context) => const GroundWaterPumpForm(),
      AppConstants.navigateToPumpsForm: (context) => const PumpsForm(),
      AppConstants.navigateToOHSRForm: (context) => const OHSRForm(),
      AppConstants.navigateToGSRForm: (context) => const GSRForm(),
      AppConstants.navigateToSpringWaterForm: (context) => const SpringWaterForm(),
      AppConstants.navigateToDistributionSupplyForm: (context) => const DistributionSupplyForm(),
      AppConstants.navigateToDisinfectionForm: (context) => const DisinfectionForm(),
      AppConstants.navigateToNonSupplyForm: (context) => const NonSupplyForm(),
      AppConstants.navigateToEscalationAlertsScreen: (context) => const EscalationAlertsScreen(),

    };
  }
}
