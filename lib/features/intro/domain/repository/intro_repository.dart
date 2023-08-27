import 'package:instagram_clone/common/resources/data_state.dart';

abstract class IntroRepository {
  Future<DataState<bool>> checkConnection();
  Future<bool> readDarkMode();
  Future<void> setDarkMode(bool value);
}
