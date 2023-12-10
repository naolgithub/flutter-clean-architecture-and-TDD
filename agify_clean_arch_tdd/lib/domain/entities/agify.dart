import 'package:equatable/equatable.dart';

class AgifyEntity extends Equatable {
  final String name;
  final int count;
  final int age;
  const AgifyEntity({
    required this.name,
    required this.count,
    required this.age,
  });

  @override
  List<Object> get props => [name, count, age];
}
