import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/agify.dart';

abstract class AgifyRepository {
  Future<Either<Failure, AgifyEntity>> getCurrentAgify(String name);
}
