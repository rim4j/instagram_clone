import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/common/resources/data_state.dart';

import 'package:instagram_clone/features/intro/domain/usecase/check_connection_usecase.dart';
import 'package:instagram_clone/features/intro/domain/usecase/read_dark_mode_usecase.dart';
import 'package:instagram_clone/features/intro/domain/usecase/set_dark_mode_usecase.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/change_theme_status.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/check_connection_status.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final CheckConnectionUseCase checkConnectionUseCase;
  final SetDarkModeUseCase setDarkModeUseCase;
  final ReadDarkModeUseCase readDarkModeUseCase;

  IntroBloc({
    required this.checkConnectionUseCase,
    required this.setDarkModeUseCase,
    required this.readDarkModeUseCase,
  }) : super(
          IntroState(
            checkConnectionStatus: CheckConnectionInit(),
            changeThemeStatus: DarkMode(isDarkMode: false),
          ),
        ) {
    on<CheckConnectionEvent>(_checkConnectionEvent);
    on<IsDarkModeEvent>(_isDarkModeEvent);
    on<InitIsDarkModeEvent>(_initIsDarkModeEvent);
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

  void _isDarkModeEvent(IsDarkModeEvent event, Emitter<IntroState> emit) async {
    DarkMode darkMode = state.changeThemeStatus as DarkMode;
    if (darkMode.isDarkMode) {
      emit(state.copyWith(newChangeThemeStatus: DarkMode(isDarkMode: false)));
      await setDarkModeUseCase(params: false);
    } else {
      emit(state.copyWith(newChangeThemeStatus: DarkMode(isDarkMode: true)));
      await setDarkModeUseCase(params: true);
    }
  }

  void _initIsDarkModeEvent(
      InitIsDarkModeEvent event, Emitter<IntroState> emit) async {
    bool initDarkMode = await readDarkModeUseCase();

    emit(state.copyWith(
        newChangeThemeStatus: DarkMode(isDarkMode: initDarkMode)));
  }
}
