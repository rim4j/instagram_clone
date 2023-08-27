import 'package:equatable/equatable.dart';

abstract class ChangeThemeStatus extends Equatable {}

class DarkMode extends ChangeThemeStatus {
  final bool isDarkMode;

  DarkMode({
    required this.isDarkMode,
  });

  @override
  List<Object?> get props => [isDarkMode];
}
