// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:agify_clean_arch_tdd/data/data_sources/remote_data_source.dart';
import 'package:agify_clean_arch_tdd/domain/entities/agify.dart';
import 'package:agify_clean_arch_tdd/domain/repository/agify_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../data_sources/local_data_source.dart';

class AgifyRepositoryImpl extends AgifyRepository {
  final AgifyRemoteDataSource agifyRemoteDataSource;
  final AgifyLocalDataSource agifyLocalDataSource;
  final NetworkInfo networkInfo;
  AgifyRepositoryImpl({
    required this.agifyRemoteDataSource,
    required this.agifyLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AgifyEntity>> getCurrentAgify(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAgify = await agifyRemoteDataSource.getCurrentAgify(name);
        await agifyLocalDataSource.cacheAgify(remoteAgify);
        return Right(remoteAgify.toEntity());
      } on ServerException {
        return const Left(ServerFailure('An error has occurred'));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      try {
        final localAgify = await agifyLocalDataSource.getLastAgify();
        return Right(localAgify);
      } on CacheException {
        return const Left(CacheFailure('Failed to cache the agify data'));
      }
    }
  }
}
