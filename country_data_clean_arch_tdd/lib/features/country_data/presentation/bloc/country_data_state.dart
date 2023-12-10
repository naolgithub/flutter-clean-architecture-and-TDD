import 'package:equatable/equatable.dart';

import '../../domain/entities/country_data.dart';

abstract class CountryDataState extends Equatable {
  const CountryDataState();
  @override
  List<Object?> get props => [];
}

class CountryDataEmpty extends CountryDataState {}

class CountryDataLoading extends CountryDataState {}

class CountryDataLoaded extends CountryDataState {
  final CountryDataEntity result;
  const CountryDataLoaded(this.result);
  @override
  List<Object?> get props => [result];
}

class CountryDataLoadFailure extends CountryDataState {
  final String message;
  const CountryDataLoadFailure(this.message);
  @override
  List<Object?> get props => [message];
}
