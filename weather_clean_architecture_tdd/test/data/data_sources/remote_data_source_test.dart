import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:weather_clean_architecture_tdd/core/constants/constants.dart';
import 'package:weather_clean_architecture_tdd/core/error/exception.dart';
import 'package:weather_clean_architecture_tdd/data/data_sources/remote_data_source.dart';
import 'package:weather_clean_architecture_tdd/data/models/weather_model.dart';

import '../../helpers/dummy_data/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  // Testing the getting response from API
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourecImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourecImpl(client: mockHttpClient);
  });

  const testCityName = 'New York';

  group('Get current weather from API:', () {
    test(
        'Should return a valid weather model when the response is 200 or successful',
        () async {
      // We have to STUB the data to make sure mock client
      // returns the right response data
      // when we call the get current weather endpoint

      // stubbing meaning (returning a fake number)

      // eg.when the test calls the get current weather endpoint
      // using mock client we should return a response object
      // with status code 200

      // It is as follows:

      //arrange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'), 200));

      //act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, isA<WeatherModel>());
    });

    test(
      'Should throw a server exception when response code is 404 or other',
      () async {
        //arrange
        when(
          mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))),
        ).thenAnswer((_) async => http.Response('Not found', 404));

        //act
        final result =
            weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

        //assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
