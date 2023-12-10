// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repository/weather_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final WeatherLocalDataSource weatherLocalDataSource;
  final NetworkInfo networkInfo;
  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
    required this.weatherLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather =
            await weatherRemoteDataSource.getCurrentWeather(cityName);
        await weatherLocalDataSource.cacheWeather(remoteWeather);
        return Right(remoteWeather.toEntity());
      } on ServerException {
        return const Left(ServerFailure('An error has occurred'));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      try {
        final localWeather = await weatherLocalDataSource.getLastWeather();
        return Right(localWeather);
      } on CacheException {
        return const Left(CacheFailure('Failed to cache the weather data'));
      }
    }
  }
}
