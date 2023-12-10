import 'package:equatable/equatable.dart';

abstract class CountryDataEvent extends Equatable {
  const CountryDataEvent();
  @override
  List<Object?> get props => [];
}

class OnCountryChanged extends CountryDataEvent {
  final String country;
  const OnCountryChanged(this.country);
  @override
  List<Object?> get props => [country];
}
