import 'dart:io';

import 'package:instagram_clone/common/resources/data_state.dart';
import 'package:instagram_clone/features/intro/domain/repository/intro_repository.dart';

class IntroRepositoryImpl implements IntroRepository {
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
}
