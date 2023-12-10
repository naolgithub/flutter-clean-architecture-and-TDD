// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/get_country_data.dart';
import 'country_data_event.dart';
import 'country_data_state.dart';

class CountryDataBloc extends Bloc<CountryDataEvent, CountryDataState> {
  final GetCountryDataUseCase _getCountryDataUseCase;
  CountryDataBloc(
    this._getCountryDataUseCase,
  ) : super(CountryDataEmpty()) {
    on<OnCountryChanged>(
      (event, emit) async {
        emit(CountryDataLoading());
        final result = await _getCountryDataUseCase.execute(event.country);
        result.fold(
          (failure) {
            emit(CountryDataLoadFailure(failure.message));
          },
          (data) {
            emit(CountryDataLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
