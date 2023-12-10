import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/country_data_model.dart';

abstract class CountryDataRemoteDataSource {
  Future<CountryDataModel> getCountryData(String country);
}

class CountryDataRemoteDataSourecImpl extends CountryDataRemoteDataSource {
  final http.Client client;

  CountryDataRemoteDataSourecImpl({required this.client});

  @override
  Future<CountryDataModel> getCountryData(String country) async {
    final response = await client.get(Uri.parse(
        'https://restcountries.com/v3.1/name/$country?fullText=true'));
    if (response.statusCode == 200) {
      // return CountryDataModel.fromJson(jsonDecode(response.body));
      return CountryDataModel.fromMap(json.decode(response.body)[0]);
    } else {
      throw ServerException();
    }
  }
}
