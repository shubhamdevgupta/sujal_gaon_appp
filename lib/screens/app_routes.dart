import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/screens/auth/pre_login_screen.dart';
import 'package:jal_sanchalan/screens/panchayat/panchayat_landing_screen.dart';
import 'package:jal_sanchalan/screens/panchayat/panchayat_login.dart';
import 'package:jal_sanchalan/screens/panchayat/vwsc_member_list.dart';
import 'package:jal_sanchalan/screens/ssg_member/question_cat/basicdetails.dart';
import 'package:jal_sanchalan/screens/ssg_member/question_cat/locationform.dart';
import 'package:jal_sanchalan/screens/ssg_member/question_cat/monthlychargecollection.dart';
import 'package:jal_sanchalan/screens/ssg_member/question_cat/saniSanitaryinspection.dart';
import 'package:jal_sanchalan/screens/ssg_member/question_cat/watersampledataform.dart';
import 'package:jal_sanchalan/screens/ssg_member/ssg_landingpage.dart';
import 'package:jal_sanchalan/screens/ssg_member/ssg_login.dart';
import 'package:jal_sanchalan/screens/ssg_member/ssg_questionscategory.dart';
import 'package:jal_sanchalan/screens/vwsc/member_list/members_tab_screen.dart';
import 'package:jal_sanchalan/screens/vwsc/ssg_registration.dart';
import 'package:jal_sanchalan/screens/vwsc/wso_registration.dart';
import 'package:jal_sanchalan/screens/vwsc/vwsc_landing_screen.dart';
import 'package:jal_sanchalan/screens/vwsc/vwsc_login.dart';
import 'package:jal_sanchalan/screens/wso/main_wso_inventory.dart';
import 'package:jal_sanchalan/screens/wso/regular_wso_category.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/disinfection_chlorination.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/distribution_supply.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/escaltion_alters.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/gls_reservoir.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/nonsupply_distruptions.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/ohsr/overhead_service_main.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/ohsr/overhead_service_regular.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/spring_water.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/water_pump/pumping_main.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/water_pump/pumping_regular.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/water_source/groundwatersourcetube_main.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/water_source/groundwatersourcetube_regular.dart';
import 'package:jal_sanchalan/screens/wso/wso_cat/water_supply_component.dart';
import 'package:jal_sanchalan/screens/wso/wso_landingpage.dart';
import 'package:jal_sanchalan/screens/wso/wso_login.dart';

import '../utils/app_constants.dart';
import 'auth/splash_screen.dart';

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
          const WSORegistrationForm(),
      AppConstants.navigateToSHGFTKRegistrationForm: (context) =>
          const SSGMemberRegistrationForm(),
      AppConstants.navigateToVWSCMemberScrenn: (context) => MembersTabScreen(),

      // SUJALAM SHAKTI GROUP MEMBER
      AppConstants.navigateToSSGLogin: (context) => SSGMemberLogin(),
      AppConstants.navigateToSSGLandingpage: (context) => SsgLandingpage(),
      AppConstants.navigateToSSGQuestionscategory: (context) =>
          SSGQuestionscategory(),
      AppConstants.navigateToBasicDetailsForm: (context) => Basicdetails(),
      AppConstants.navigateToLocationFormScreen: (context) =>
          LocationFormScreen(),
      AppConstants.navigateToWaterSampleForm: (context) => WaterSampleForm(),
      AppConstants.navigateToSanitaryInspectionForm: (context) =>
          SanitaryInspectionForm(),
      AppConstants.navigateToMonthlyChargeCollectionForm: (context) =>
          MonthlyChargeCollectionForm(),

      // WSO (Water Supply Operator)
      AppConstants.navigateToWSOLogin: (context) => WsoLogin(),
      AppConstants.navigateToWSOLandingPage: (context) => WsoLandingpage(),
      AppConstants.navigateToWSOCategory: (context) => const WsoInventoryMain(),
      AppConstants.navigateToGroundwatersourcetubeMain: (context) =>
          const GroundwatersourcetubeMain(),
      AppConstants.navigateToGroundwatersourcetubeRegular: (context) =>
          const GroundwatersourcetubeRegular(),
      AppConstants.navigateToPumpingMain: (context) => const PumpingMain(),
      AppConstants.navigateToPumpingRegular: (context) =>
          const PumpingRegular(),
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
      AppConstants.navigateToWSORegularEntry: (context) =>
          const WsoRegularEntry(),
      AppConstants.navigateToWaterSupplyComponent: (context) =>
          const WaterSupplyComponent(),
    };
  }
}
