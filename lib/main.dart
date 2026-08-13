import 'package:flutter/material.dart';
import 'package:jal_sanchalan/providers/authentication_provider.dart';
import 'package:jal_sanchalan/providers/master_provider.dart';
import 'package:jal_sanchalan/providers/wso/ohsr_provider.dart';
import 'package:jal_sanchalan/providers/wso/wso_provider.dart';
import 'package:jal_sanchalan/providers/wso_ssg_provider.dart';
import 'package:jal_sanchalan/providers/panchayat/panchayat_provider.dart';
import 'package:jal_sanchalan/providers/update_provider.dart';
import 'package:jal_sanchalan/providers/vwsc/vwsc_provider.dart';
import 'package:jal_sanchalan/repository/authentication_repository.dart';
import 'package:jal_sanchalan/repository/master_repositary.dart';
import 'package:jal_sanchalan/repository/njm_ftk_repository.dart';
import 'package:jal_sanchalan/repository/njm_wso/njm_wso_repo.dart';
import 'package:jal_sanchalan/repository/panchayat/panchayat_repo.dart';
import 'package:jal_sanchalan/repository/vwsc/vwsc_repo.dart';
import 'package:jal_sanchalan/screens/app_routes.dart';
import 'package:jal_sanchalan/service/local_storage_service.dart';
import 'package:jal_sanchalan/utils/AppUtil.dart';
import 'package:jal_sanchalan/utils/app_constants.dart';
import 'package:jal_sanchalan/utils/device_utils.dart';
import 'package:provider/provider.dart';

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
