import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_clean_architecture_tdd/data/models/weather_model.dart';
import 'package:weather_clean_architecture_tdd/domain/entities/weather.dart';

import '../../helpers/dummy_data/json_reader.dart';

void main() {
  //We will test three main things:

  //1.Is the model we have created equal
  //with the entities at the domain layer

  //2.Does from json function return a valid model

  //3.Does toJson function return the
  //appropriate json map

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );
  test(
    'Weather model should be a subclass of weather entity',
    () async {
      //assert
      expect(testWeatherModel, isA<WeatherEntity>());
    },
  );
  test(
    'Should return a valid weather model from json',
    () async {
      //arrange
      final Map<String, dynamic> jsonMap = jsonDecode(
        readJson('helpers/dummy_data/dummy_weather_response.json'),
      );
      //act
      final result = WeatherModel.fromJson(jsonMap);

      //assert
      expect(result, equals(testWeatherModel));
    },
  );
  test(
    'Should return a json map containing a proper data',
    () async {
      //arrange

      //act
      final result = testWeatherModel.toJson();

      //assert
      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01n',
          }
        ],
        'main': {
          'temp': 292.87,
          'pressure': 1012,
          'humidity': 70,
        },
        'name': 'New York',
      };
      expect(result, equals(expectedJsonMap));
    },
  );
}
