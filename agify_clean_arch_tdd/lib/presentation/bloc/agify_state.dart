import 'package:equatable/equatable.dart';

import '../../domain/entities/agify.dart';

abstract class AgifyState extends Equatable {
  const AgifyState();
  @override
  List<Object?> get props => [];
}

class AgifyEmpty extends AgifyState {}

class AgifyLoading extends AgifyState {}

class AgifyLoaded extends AgifyState {
  final AgifyEntity result;
  const AgifyLoaded(this.result);
  @override
  List<Object?> get props => [result];
}

class AgifyLoadFailure extends AgifyState {
  final String message;
  const AgifyLoadFailure(this.message);
  @override
  List<Object?> get props => [message];
}
