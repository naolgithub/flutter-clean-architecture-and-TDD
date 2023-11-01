import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_clean_architecture_tdd/domain/entities/weather.dart';
import 'package:weather_clean_architecture_tdd/domain/usecases/get_current_weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  //Writing a test for a usecase
  //get_current_weather.dart file

/*
  What do we want to test really?
  ans: We want to ensure that the repository
       is actually called and the data is simply passes
       unchanged through the usecase
   */
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  late MockWeatherRepository mockWeatherRepository;
  //setup runs before every individual tests
  setUp(() {
    //creating instance of mock weather repository class
    mockWeatherRepository = MockWeatherRepository();
    //creating instance of get current weather usecase class
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(
      weatherRepository: mockWeatherRepository,
    );
  });
  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );
  const testCityName = 'New York';
  test('Should get current weather detail from the repository', () async {
    //arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));

    //act
    final result = await getCurrentWeatherUseCase.execute(testCityName);

    //assert
    expect(result, const Right(testWeatherDetail));
  });
}
