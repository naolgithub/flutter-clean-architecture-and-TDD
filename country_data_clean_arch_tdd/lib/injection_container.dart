import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/country_data/data/data_sources/local_data_source.dart';
import 'features/country_data/data/data_sources/remote_data_source.dart';
import 'features/country_data/data/repositories/country_data_repository_impl.dart';
import 'features/country_data/domain/repository/country_data_repository.dart';
import 'features/country_data/domain/usecases/get_country_data.dart';
import 'features/country_data/presentation/bloc/country_data_bloc.dart';

//implementation of dependency injection using get_it package
final locator = GetIt.instance;
Future<void> setUpLocator() async {
  //registering bloc
  locator.registerFactory(() => CountryDataBloc(locator()));
  //registering usecase
  locator.registerLazySingleton(
      () => GetCountryDataUseCase(countryDataRepository: locator()));
  //registering repository
  locator.registerLazySingleton<CountryDataRepository>(
      () => CountryDataRepositoryImpl(
            countryDataRemoteDataSource: locator(),
            countryDataLocalDataSource: locator(),
            networkInfo: locator(),
          ));
  //registering data source
  locator.registerLazySingleton<CountryDataRemoteDataSource>(
      () => CountryDataRemoteDataSourecImpl(client: locator()));
  locator.registerLazySingleton<CountryDataLocalDataSource>(
      () => CountryDataLocalDataSourceImpl(sharedPreferences: locator()));

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
