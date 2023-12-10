import '../../domain/entities/country_data.dart';

class CountryDataModel extends CountryDataEntity {
  const CountryDataModel({
    required super.commonName,
    required super.officialName,
    required super.independent,
    required super.status,
    required super.unMember,
    required super.capitalCity,
    required super.flag,
    required super.timeZone,
    required super.region,
    required super.subregion,
    required super.latitude,
    required super.longitude,
    required super.landLocked,
    required super.area,
    required super.population,
    required super.startOfWeek,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commonName': commonName,
      'officialName': officialName,
      'independent': independent,
      'status': status,
      'unMember': unMember,
      'capitalCity': capitalCity,
      'flag': flag,
      'timeZone': timeZone,
      'region': region,
      'subregion': subregion,
      'latitude': latitude,
      'longitude': longitude,
      'landLocked': landLocked,
      'area': area,
      'population': population,
      'startOfWeek': startOfWeek,
    };
  }

  factory CountryDataModel.fromMap(Map<String, dynamic> map) {
    return CountryDataModel(
      commonName: map['name']['common'] as dynamic,
      officialName: map['name']['official'] as dynamic,
      independent: map['independent'] as dynamic,
      status: map['status'] as dynamic,
      unMember: map['unMember'] as dynamic,
      capitalCity: map['capital'][0] as dynamic,
      flag: map['flag'] as dynamic,
      timeZone: map['timezones'][0] as dynamic,
      region: map['region'] as dynamic,
      subregion: map['subregion'] as dynamic,
      latitude: map['latlng'][0] as dynamic,
      longitude: map['latlng'][1] as dynamic,
      landLocked: map['landLocked'] as dynamic,
      area: map['area'] as dynamic,
      population: map['population'] as dynamic,
      startOfWeek: map['startOfWeek'] as dynamic,
    );
  }
}
