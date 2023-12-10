// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:country_data_clean_arch_tdd/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/country_data.dart';
import '../../domain/repository/country_data_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class CountryDataRepositoryImpl extends CountryDataRepository {
  final CountryDataRemoteDataSource countryDataRemoteDataSource;
  final CountryDataLocalDataSource countryDataLocalDataSource;
  final NetworkInfo networkInfo;
  CountryDataRepositoryImpl({
    required this.countryDataRemoteDataSource,
    required this.countryDataLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CountryDataEntity>> getCountryData(
      String country) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCountryData =
            await countryDataRemoteDataSource.getCountryData(country);
        await countryDataLocalDataSource.cacheCountryData(remoteCountryData);
        return Right(remoteCountryData);
      } on ServerException {
        return const Left(ServerFailure('An error has occurred'));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      try {
        final localCountryData =
            await countryDataLocalDataSource.getLastCountryData();
        return Right(localCountryData);
      } on CacheException {
        return const Left(CacheFailure('Failed to cache the CountryData'));
      }
    }
  }
}
