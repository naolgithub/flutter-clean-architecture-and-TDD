// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agify_clean_arch_tdd/domain/entities/agify.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../repository/agify_repository.dart';

class GetCurrentAgifyUseCase {
  final AgifyRepository agifyRepository;
  GetCurrentAgifyUseCase({
    required this.agifyRepository,
  });
  Future<Either<Failure, AgifyEntity>> execute(String name) {
    return agifyRepository.getCurrentAgify(name);
  }
}
