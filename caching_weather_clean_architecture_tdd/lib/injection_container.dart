import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'data/data_sources/local_data_source.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repository/weather_repository.dart';
import 'domain/usecases/get_current_weather.dart';
import 'presentation/bloc/weather_bloc.dart';

//implementation of dependency injection using get_it package
final locator = GetIt.instance;
Future<void> setUpLocator() async {
  //registering bloc
  locator.registerFactory(() => WeatherBloc(locator()));
  //registering usecase
  locator.registerLazySingleton(
      () => GetCurrentWeatherUseCase(weatherRepository: locator()));
  //registering repository
  locator.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
        weatherRemoteDataSource: locator(),
        weatherLocalDataSource: locator(),
        networkInfo: locator(),
      ));
  //registering data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourecImpl(client: locator()));
  locator.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl(sharedPreferences: locator()));
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
