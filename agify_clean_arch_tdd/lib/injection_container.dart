import 'package:agify_clean_arch_tdd/data/data_sources/local_data_source.dart';
import 'package:agify_clean_arch_tdd/data/data_sources/remote_data_source.dart';
import 'package:agify_clean_arch_tdd/data/repositories/agify_repository_impl.dart';
import 'package:agify_clean_arch_tdd/domain/repository/agify_repository.dart';
import 'package:agify_clean_arch_tdd/domain/usecases/get_current_agify.dart';
import 'package:agify_clean_arch_tdd/presentation/bloc/agify_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';

//implementation of dependency injection using get_it package
final locator = GetIt.instance;
Future<void> setUpLocator() async {
  //registering bloc
  locator.registerFactory(() => AgifyBloc(locator()));
  //registering usecase
  locator.registerLazySingleton(
      () => GetCurrentAgifyUseCase(agifyRepository: locator()));
  //registering repository
  locator.registerLazySingleton<AgifyRepository>(() => AgifyRepositoryImpl(
        agifyRemoteDataSource: locator(),
        agifyLocalDataSource: locator(),
        networkInfo: locator(),
      ));
  //registering data source
  locator.registerLazySingleton<AgifyRemoteDataSource>(
      () => AgifyRemoteDataSourecImpl(client: locator()));
  locator.registerLazySingleton<AgifyLocalDataSource>(
      () => AgifyLocalDataSourceImpl(sharedPreferences: locator()));
  //registering core
  locator.registerLazySingleton<NetworkInfo>(() => InternetNetworkInfoImpl(
        internetConnectionChecker: locator(),
      ));
  //registering external packages and plugin
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => InternetConnectionChecker());
}
