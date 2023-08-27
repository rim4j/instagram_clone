part of 'intro_bloc.dart';

class IntroState extends Equatable {
  final CheckConnectionStatus checkConnectionStatus;
  final ChangeThemeStatus changeThemeStatus;

  const IntroState({
    required this.checkConnectionStatus,
    required this.changeThemeStatus,
  });

  IntroState copyWith({
    CheckConnectionStatus? newCheckConnectionStatus,
    ChangeThemeStatus? newChangeThemeStatus,
  }) {
    return IntroState(
      checkConnectionStatus: newCheckConnectionStatus ?? checkConnectionStatus,
      changeThemeStatus: newChangeThemeStatus ?? changeThemeStatus,
    );
  }

  @override
  List<Object?> get props => [checkConnectionStatus, changeThemeStatus];
}
