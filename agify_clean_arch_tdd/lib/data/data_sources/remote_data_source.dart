import 'dart:convert';

import 'package:agify_clean_arch_tdd/core/error/exceptions.dart';
import 'package:http/http.dart' as http;

import '../models/agify_model.dart';

abstract class AgifyRemoteDataSource {
  Future<AgifyModel> getCurrentAgify(String name);
}

class AgifyRemoteDataSourecImpl extends AgifyRemoteDataSource {
  final http.Client client;

  AgifyRemoteDataSourecImpl({
    required this.client,
  });

  @override
  Future<AgifyModel> getCurrentAgify(String name) async {
    final response =
        await client.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      // return AgifyModel.fromJson(jsonDecode(response.body));
      return AgifyModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
