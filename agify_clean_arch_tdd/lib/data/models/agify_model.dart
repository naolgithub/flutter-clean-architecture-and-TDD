import 'package:agify_clean_arch_tdd/domain/entities/agify.dart';

class AgifyModel extends AgifyEntity {
  const AgifyModel({
    required String name,
    required int count,
    required int age,
  }) : super(
          name: name,
          count: count,
          age: age,
        );
  factory AgifyModel.fromJson(Map<String, dynamic> json) => AgifyModel(
        name: json['name'],
        count: json['count'],
        age: json['age'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'count': count,
        'age': age,
      };
  AgifyEntity toEntity() => AgifyEntity(
        name: name,
        count: count,
        age: age,
      );
}
