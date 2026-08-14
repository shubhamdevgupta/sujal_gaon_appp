import 'package:flutter/cupertino.dart';
import 'package:sujalam_bharat/screens/role_based/dwsm/dwsm_landing_screen.dart';
import 'package:sujalam_bharat/screens/role_based/dwsm/dwsm_login.dart';
import 'package:sujalam_bharat/screens/role_based/panchayat/auth/panchayat_landing_screen.dart';
import 'package:sujalam_bharat/screens/role_based/panchayat/auth/panchayat_login.dart';
import 'package:sujalam_bharat/screens/role_based/panchayat/ssg_reg/members_communityMobilization.dart';
import 'package:sujalam_bharat/screens/role_based/panchayat/ssg_reg/members_communityWQMS.dart';
import 'package:sujalam_bharat/screens/role_based/panchayat/ssg_reg/ssg_registration.dart';
import 'package:sujalam_bharat/screens/role_based/panchayat/vwsc_member_list.dart';
import 'package:sujalam_bharat/screens/role_based/panchayat/wso_registration.dart';
import 'package:sujalam_bharat/screens/role_based/ssg_member/auth/ssg_landingpage.dart';
import 'package:sujalam_bharat/screens/role_based/ssg_member/auth/ssg_login.dart';
import 'package:sujalam_bharat/screens/role_based/ssg_member/question_cat/basicdetails.dart';
import 'package:sujalam_bharat/screens/role_based/ssg_member/question_cat/locationform.dart';
import 'package:sujalam_bharat/screens/role_based/ssg_member/question_cat/monthlychargecollection.dart';
import 'package:sujalam_bharat/screens/role_based/ssg_member/question_cat/saniSanitaryinspection.dart';
import 'package:sujalam_bharat/screens/role_based/ssg_member/question_cat/watersampledataform.dart';
import 'package:sujalam_bharat/screens/role_based/ssg_member/ssg_questionscategory.dart';
import 'package:sujalam_bharat/screens/role_based/vwsc/member_list/members_tab_screen.dart';
import 'package:sujalam_bharat/screens/role_based/vwsc/vwsc_landing_screen.dart';
import 'package:sujalam_bharat/screens/role_based/vwsc/vwsc_login.dart';
import 'package:sujalam_bharat/screens/role_based/wso/auth/wso_landingpage.dart';
import 'package:sujalam_bharat/screens/role_based/wso/auth/wso_login.dart';
import 'package:sujalam_bharat/screens/role_based/wso/auth/wso_user_verify.dart';
import 'package:sujalam_bharat/screens/role_based/wso/main_wso_inventory.dart';
import 'package:sujalam_bharat/screens/role_based/wso/regular_wso_category.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/disinfection_chlorination.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/distribution_supply.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/escaltion_alters.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/gls_reservoir.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/nonsupply_distruptions.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/ohsr/overhead_service_main.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/ohsr/overhead_service_regular.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/spring_water.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/water_pump/pumping_main.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/water_pump/pumping_regular.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/water_source/groundwatersourcetube_main.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/water_source/groundwatersourcetube_regular.dart';
import 'package:sujalam_bharat/screens/role_based/wso/wso_cat/water_supply_component.dart';


import '../utils/app_constants.dart';
import 'auth/pre_login_screen.dart';
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

      //dwsm
      AppConstants.navigateToDwsmLogin: (context) => const DwsmLogin(),
      AppConstants.navigateToDwsmLandingPage: (context) => const DwsmLandingScreen(),

      //Village Water
      AppConstants.navigateToVwscLogin: (context) => const VwscLogin(),
      AppConstants.navigateToVWSCLandingScreen: (context) =>
          const VwscLandingScreen(),
      AppConstants.navigateToWsoRegistrationForm: (context) =>
          const WSORegistrationForm(),
      AppConstants.navigateToSSGRegistrationForm: (context) =>
          const SSGMemberRegistrationForm(),
      AppConstants.navigateToVWSCMemberScrenn: (context) => MembersTabScreen(),
      AppConstants.navigateToMembersCommunitywqms: (context) =>
          MembersCommunitywqms(),
      AppConstants.navigateToMembersCommunitymobilization: (context) =>
          MembersCommunitymobilization(),

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
      AppConstants.navigateToWSOUserVerifyPage: (context) =>
          WsoUserVerifyPage(),
    };
  }
}
