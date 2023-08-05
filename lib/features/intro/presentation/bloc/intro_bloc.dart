import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/common/resources/data_state.dart';

import 'package:instagram_clone/features/intro/domain/usecase/check_connection_usecase.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/check_connection_status.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final CheckConnectionUseCase checkConnectionUseCase;

  IntroBloc({
    required this.checkConnectionUseCase,
  }) : super(
          IntroState(checkConnectionStatus: CheckConnectionInit()),
        ) {
    on<CheckConnectionEvent>(_checkConnectionEvent);
  }

  void _checkConnectionEvent(
    CheckConnectionEvent event,
    Emitter<IntroState> emit,
  ) async {
    DataState dataState = await checkConnectionUseCase();

    if (dataState is DataSuccess) {
      emit(state.copyWith(newCheckConnectionStatus: CheckConnectionOn()));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(
        newCheckConnectionStatus: CheckConnectionOff(message: dataState.error!),
      ));
    }
  }
}
