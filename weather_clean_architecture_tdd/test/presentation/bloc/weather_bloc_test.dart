import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_clean_architecture_tdd/core/error/failure.dart';
import 'package:weather_clean_architecture_tdd/domain/entities/weather.dart';
import 'package:weather_clean_architecture_tdd/presentation/bloc/weather_bloc.dart';
import 'package:weather_clean_architecture_tdd/presentation/bloc/weather_event.dart';
import 'package:weather_clean_architecture_tdd/presentation/bloc/weather_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  //In the bloc we need to call the get current weather method
  // in the repository through usecase and the repository
  // will get the data from the remote data source and
  // the remote data source through the API return data to us

  //so we need to access the get current weather usecase
  //but we have to mock it.
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;
  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });
  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );
  const testCityName = 'New York';
  test('initial weather state should be weather empty', () {
    //assert
    expect(weatherBloc.state, WeatherEmpty());
  });
  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading,WeatherLoaded] when data is gotten successfuly',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName))
            .thenAnswer((_) async => const Right(testWeather));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            WeatherLoading(),
            const WeatherLoaded(testWeather),
          ]);

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading,WeatherLoadFailure] when data is gotten unsuccessful',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            WeatherLoading(),
            const WeatherLoadFailure('Server failure'),
          ]);
}
