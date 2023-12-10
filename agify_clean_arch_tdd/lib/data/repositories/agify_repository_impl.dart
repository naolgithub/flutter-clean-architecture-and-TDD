// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:agify_clean_arch_tdd/data/data_sources/remote_data_source.dart';
import 'package:agify_clean_arch_tdd/domain/entities/agify.dart';
import 'package:agify_clean_arch_tdd/domain/repository/agify_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';

class AgifyRepositoryImpl extends AgifyRepository {
  final AgifyRemoteDataSource agifyRemoteDataSource;
  AgifyRepositoryImpl({
    required this.agifyRemoteDataSource,
  });

  @override
  Future<Either<Failure, AgifyEntity>> getCurrentAgify(String name) async {
    try {
      final result = await agifyRemoteDataSource.getCurrentAgify(name);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
