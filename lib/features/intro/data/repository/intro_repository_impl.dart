import 'dart:io';

import 'package:instagram_clone/common/resources/data_state.dart';
import 'package:instagram_clone/features/intro/data/data_source/local/intro_local_data_source.dart';
import 'package:instagram_clone/features/intro/domain/repository/intro_repository.dart';

class IntroRepositoryImpl implements IntroRepository {
  final IntroLocalDataSource introLocalDataSource;

  IntroRepositoryImpl({
    required this.introLocalDataSource,
  });
  @override
  Future<DataState<bool>> checkConnection() async {
    try {
      final result = await InternetAddress.lookup("example.com");
      final connection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      if (connection) {
        return DataSuccess(connection);
      } else {
        return const DataFailed("please check your connection");
      }
    } catch (e) {
      return const DataFailed("Please connect to the internet");
    }
  }

  @override
  Future<bool> readDarkMode() async {
    var result = await introLocalDataSource.readDarkModeStorage();

    if (result == null) {
      return false;
    } else {
      bool isDarkMode = bool.parse("$result");
      return isDarkMode;
    }
  }

  @override
  Future<void> setDarkMode(bool value) =>
      introLocalDataSource.setDarkModeStorage(value);
}
