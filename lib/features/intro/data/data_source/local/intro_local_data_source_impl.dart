import 'package:instagram_clone/common/utils/custom_storage.dart';
import 'package:instagram_clone/features/intro/data/data_source/local/intro_local_data_source.dart';

class IntroLocalDataSourceImpl implements IntroLocalDataSource {
  final CustomStorage customStorage = CustomStorage();
  @override
  Future readDarkModeStorage() async =>
      await customStorage.readStorage("isDarkMode");

  @override
  Future<void> setDarkModeStorage(bool value) async =>
      await customStorage.writeStorage("isDarkMode", value);
}
