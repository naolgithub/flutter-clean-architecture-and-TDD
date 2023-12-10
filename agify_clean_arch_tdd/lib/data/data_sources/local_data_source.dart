import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/exceptions.dart';
import '../models/agify_model.dart';

abstract class AgifyLocalDataSource {
  /// Gets the cached [AgifyModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<AgifyModel> getLastAgify();
  Future<void> cacheAgify(AgifyModel agifyToCache);
}

const CACHED_AGIFY = 'CACHED_AGIFY';

class AgifyLocalDataSourceImpl implements AgifyLocalDataSource {
  final SharedPreferences sharedPreferences;
  AgifyLocalDataSourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<void> cacheAgify(AgifyModel agifyToCache) {
    return sharedPreferences.setString(
      CACHED_AGIFY,
      json.encode(agifyToCache.toJson()),
    );
  }

  @override
  Future<AgifyModel> getLastAgify() {
    final jsonString = sharedPreferences.getString(CACHED_AGIFY);
    if (jsonString != null) {
      return Future.value(AgifyModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
