// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/weather.dart';
import '../repository/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;
  GetCurrentWeatherUseCase({
    required this.weatherRepository,
  });
  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
