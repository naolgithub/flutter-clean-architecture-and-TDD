import 'package:equatable/equatable.dart';

abstract class AgifyEvent extends Equatable {
  const AgifyEvent();
  @override
  List<Object?> get props => [];
}

class OnNameChanged extends AgifyEvent {
  final String name;
  const OnNameChanged(this.name);
  @override
  List<Object?> get props => [name];
}
