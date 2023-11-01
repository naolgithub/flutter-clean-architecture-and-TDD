import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_clean_architecture_tdd/core/error/exception.dart';
import 'package:weather_clean_architecture_tdd/data/models/weather_model.dart';

import '../../core/constants/constants.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourecImpl extends WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourecImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));
    if (response.statusCode == 200) {
      // return WeatherModel.fromJson(jsonDecode(response.body));
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
