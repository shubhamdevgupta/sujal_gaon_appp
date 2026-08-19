import 'package:get_it/get_it.dart';


import '../repository/authentication_repository.dart';
import '../repository/master_repository.dart';
import '../repository/njm_ftk_repository.dart';
import '../repository/njm_wso/njm_wso_repo.dart';
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
    ..registerLazySingleton<MasterRepository>(
      () => MasterRepository(getIt()),
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
