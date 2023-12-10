import 'package:agify_clean_arch_tdd/data/data_sources/remote_data_source.dart';
import 'package:agify_clean_arch_tdd/data/repositories/agify_repository_impl.dart';
import 'package:agify_clean_arch_tdd/domain/repository/agify_repository.dart';
import 'package:agify_clean_arch_tdd/domain/usecases/get_current_agify.dart';
import 'package:agify_clean_arch_tdd/presentation/bloc/agify_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

//implementation of dependency injection using get_it package
final locator = GetIt.instance;
void setUpLocator() {
  //registering bloc
  locator.registerFactory(() => AgifyBloc(locator()));
  //registering usecase
  locator.registerLazySingleton(
      () => GetCurrentAgifyUseCase(agifyRepository: locator()));
  //registering repository
  locator.registerLazySingleton<AgifyRepository>(
      () => AgifyRepositoryImpl(agifyRemoteDataSource: locator()));
  //registering data source
  locator.registerLazySingleton<AgifyRemoteDataSource>(
      () => AgifyRemoteDataSourecImpl(client: locator()));
  //registering external http client
  locator.registerLazySingleton(() => http.Client());
}
