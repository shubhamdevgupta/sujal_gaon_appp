import 'package:get_it/get_it.dart';
import 'package:jal_sanchalan/repository/master_repositary.dart';
import 'package:jal_sanchalan/repository/njm_ftk_repository.dart';
import 'package:jal_sanchalan/repository/njm_wso/njm_wso_repo.dart';

import '../repository/authentication_repository.dart';
import '../repository/panchayat/panchayat_repo.dart';
import '../repository/vwsc/vwsc_repo.dart';
import '../service/base_api_service.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt
    ..registerLazySingleton<BaseApiService>(() => BaseApiService())
    ..registerLazySingleton<AuthenticaitonRepository>(
      () => AuthenticaitonRepository(getIt()),
    )
    ..registerLazySingleton<MasterRepositary>(
      () => MasterRepositary(getIt()),
    )
    ..registerLazySingleton<WsoSSGRepository>(
      () => WsoSSGRepository(getIt()),
    )
    ..registerLazySingleton<WsoRepo>(
      () => WsoRepo(getIt()),
    )
    ..registerLazySingleton<VwscRepo>(() => VwscRepo(getIt()))
    ..registerLazySingleton<PanchayatRepo>(
      () => PanchayatRepo(getIt()),
    );
}
