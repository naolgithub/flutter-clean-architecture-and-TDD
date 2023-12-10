import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/weather_model.dart';

abstract class WeatherLocalDataSource {
  /// Gets the cached [WeatherModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<WeatherModel> getLastWeather();
  Future<void> cacheWeather(WeatherModel weatherToCache);
}

const CACHED_WEATHER = 'CACHED_WEATHER';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;
  WeatherLocalDataSourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<void> cacheWeather(WeatherModel weatherToCache) {
    return sharedPreferences.setString(
      CACHED_WEATHER,
      json.encode(weatherToCache.toJson()),
    );
  }

  @override
  Future<WeatherModel> getLastWeather() {
    final jsonString = sharedPreferences.getString(CACHED_WEATHER);
    if (jsonString != null) {
      return Future.value(WeatherModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
