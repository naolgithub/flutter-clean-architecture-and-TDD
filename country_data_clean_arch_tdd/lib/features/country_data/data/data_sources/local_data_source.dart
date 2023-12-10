import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/country_data_model.dart';

abstract class CountryDataLocalDataSource {
  /// Gets the cached [CountryDataModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<CountryDataModel> getLastCountryData();
  Future<void> cacheCountryData(CountryDataModel countryDataToCache);
}

const CACHED_COUNTRY_DATA = 'CACHED_COUNTRY_DATA';

class CountryDataLocalDataSourceImpl implements CountryDataLocalDataSource {
  final SharedPreferences sharedPreferences;
  CountryDataLocalDataSourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<void> cacheCountryData(CountryDataModel countryDataToCache) {
    return sharedPreferences.setString(
      CACHED_COUNTRY_DATA,
      json.encode(countryDataToCache.toMap()),
    );
  }

  @override
  Future<CountryDataModel> getLastCountryData() {
    final jsonString = sharedPreferences.getString(CACHED_COUNTRY_DATA);
    if (jsonString != null) {
      return Future.value(CountryDataModel.fromMap(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
