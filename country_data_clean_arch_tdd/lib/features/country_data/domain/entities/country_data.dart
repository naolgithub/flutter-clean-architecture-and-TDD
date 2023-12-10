// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CountryDataEntity extends Equatable {
  // final String commonName;
  // final String officialName;
  // final bool independent;
  // final String status;
  // final bool unMember;
  // final String region;
  // final String subregion;
  // final double latitude;
  // final double longitude;
  // final bool landLocked;
  // final double area;
  // final int population;
  // final String startOfWeek;
  final dynamic commonName;
  final dynamic officialName;
  final dynamic independent;
  final dynamic status;
  final dynamic unMember;
  final dynamic capitalCity;
  final dynamic flag;
  final dynamic timeZone;
  final dynamic region;
  final dynamic subregion;
  final dynamic latitude;
  final dynamic longitude;
  final dynamic landLocked;
  final dynamic area;
  final dynamic population;
  final dynamic startOfWeek;
  const CountryDataEntity({
    required this.commonName,
    required this.officialName,
    required this.independent,
    required this.status,
    required this.unMember,
    required this.capitalCity,
    required this.flag,
    required this.timeZone,
    required this.region,
    required this.subregion,
    required this.latitude,
    required this.longitude,
    required this.landLocked,
    required this.area,
    required this.population,
    required this.startOfWeek,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'commonName': commonName,
  //     'officialName': officialName,
  //     'independent': independent,
  //     'status': status,
  //     'unMember': unMember,
  //     'region': region,
  //     'subregion': subregion,
  //     'latitude': latitude,
  //     'longitude': longitude,
  //     'landLocked': landLocked,
  //     'area': area,
  //     'population': population,
  //     'startOfWeek': startOfWeek,
  //   };
  // }

  // factory CountryData.fromMap(Map<String, dynamic> map) {
  //   return CountryData(
  //     commonName: map['commonName'] as String,
  //     officialName: map['officialName'] as String,
  //     independent: map['independent'] as bool,
  //     status: map['status'] as String,
  //     unMember: map['unMember'] as bool,
  //     region: map['region'] as String,
  //     subregion: map['subregion'] as String,
  //     latitude: map['latitude'] as String,
  //     longitude: map['longitude'] as String,
  //     landLocked: map['landLocked'] as bool,
  //     area: map['area'] as double,
  //     population: map['population'] as int,
  //     startOfWeek: map['startOfWeek'] as String,
  //   );
  // }

  @override
  List<Object> get props {
    return [
      commonName,
      officialName,
      independent,
      status,
      unMember,
      region,
      subregion,
      latitude,
      longitude,
      landLocked,
      area,
      population,
      startOfWeek,
    ];
  }
}
