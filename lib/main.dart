import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sujalam_bharat/providers/authentication_provider.dart';
import 'package:sujalam_bharat/providers/master_provider.dart';
import 'package:sujalam_bharat/providers/panchayat/panchayat_provider.dart';
import 'package:sujalam_bharat/providers/update_provider.dart';
import 'package:sujalam_bharat/providers/vwsc/vwsc_provider.dart';
import 'package:sujalam_bharat/providers/wso/ohsr_provider.dart';
import 'package:sujalam_bharat/providers/wso/wso_provider.dart';
import 'package:sujalam_bharat/providers/wso_ssg_provider.dart';
import 'package:sujalam_bharat/repository/authentication_repository.dart';
import 'package:sujalam_bharat/repository/master_repositary.dart';
import 'package:sujalam_bharat/repository/njm_ftk_repository.dart';
import 'package:sujalam_bharat/repository/njm_wso/njm_wso_repo.dart';
import 'package:sujalam_bharat/repository/panchayat/panchayat_repo.dart';
import 'package:sujalam_bharat/repository/vwsc/vwsc_repo.dart';
import 'package:sujalam_bharat/screens/app_routes.dart';
import 'package:sujalam_bharat/service/local_storage_service.dart';
import 'package:sujalam_bharat/utils/AppUtil.dart';
import 'package:sujalam_bharat/utils/app_constants.dart';
import 'package:sujalam_bharat/utils/device_utils.dart';

import 'di/service_locator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();
  await AppUtil.init(); // <-- Load version at startup
  await LocalStorageService.init();
  await DeviceInfoUtil.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MasterProvider(getIt<MasterRepositary>()),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              AuthenticationProvider(getIt<AuthenticaitonRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) => PanchayatProvider(getIt<PanchayatRepo>()),
        ),
        ChangeNotifierProvider(create: (_) => VwscProvider(getIt<VwscRepo>())),
        ChangeNotifierProvider(
          create: (_) => WsoProvider(getIt<WsoRepo>()),
        ),
        ChangeNotifierProvider(
          create: (_) => WsoSSGProvider(getIt<WsoSSGRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) => OhsrProvider(getIt<WsoRepo>()),
        ),
        ChangeNotifierProvider(create: (_) => UpdateViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Sujalam Bharat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppConstants.navigateToSplashScreen,
      routes: AppRoutes.getRoutes(),
    );
  }
}
