// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agify_clean_arch_tdd/domain/usecases/get_current_agify.dart';
import 'package:agify_clean_arch_tdd/presentation/bloc/agify_event.dart';
import 'package:agify_clean_arch_tdd/presentation/bloc/agify_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AgifyBloc extends Bloc<AgifyEvent, AgifyState> {
  final GetCurrentAgifyUseCase _getCurrentAgifyUseCase;
  AgifyBloc(
    this._getCurrentAgifyUseCase,
  ) : super(AgifyEmpty()) {
    on<OnNameChanged>(
      (event, emit) async {
        emit(AgifyLoading());
        final result = await _getCurrentAgifyUseCase.execute(event.name);
        result.fold(
          (failure) {
            emit(AgifyLoadFailure(failure.message));
          },
          (data) {
            emit(AgifyLoaded(data));
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
