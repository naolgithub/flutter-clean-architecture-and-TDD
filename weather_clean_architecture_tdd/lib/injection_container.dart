import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_clean_architecture_tdd/data/data_sources/remote_data_source.dart';
import 'package:weather_clean_architecture_tdd/data/repositories/weather_repository_impl.dart';
import 'package:weather_clean_architecture_tdd/domain/repository/weather_repository.dart';
import 'package:weather_clean_architecture_tdd/domain/usecases/get_current_weather.dart';
import 'package:weather_clean_architecture_tdd/presentation/bloc/weather_bloc.dart';

//implementation of dependency injection
final locator = GetIt.instance;
void setUpLocator() {
  //registering bloc
  locator.registerFactory(() => WeatherBloc(locator()));
  //registering usecase
  locator.registerLazySingleton(
      () => GetCurrentWeatherUseCase(weatherRepository: locator()));
  //registering repository
  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()));
  //registering data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourecImpl(client: locator()));
  //registering external http client
  locator.registerLazySingleton(() => http.Client());
}
