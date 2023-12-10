// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:country_data_clean_arch_tdd/features/country_data/domain/repository/country_data_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/country_data.dart';

class GetCountryDataUseCase {
  CountryDataRepository countryDataRepository;
  GetCountryDataUseCase({
    required this.countryDataRepository,
  });

  Future<Either<Failure, CountryDataEntity>> execute(String country) async {
    return await countryDataRepository.getCountryData(country);
  }
}
