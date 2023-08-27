import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/intro/data/data_source/local/intro_local_data_source.dart';
import 'package:instagram_clone/features/intro/data/data_source/local/intro_local_data_source_impl.dart';
import 'package:instagram_clone/features/intro/data/repository/intro_repository_impl.dart';
import 'package:instagram_clone/features/intro/domain/repository/intro_repository.dart';
import 'package:instagram_clone/features/intro/domain/usecase/check_connection_usecase.dart';
import 'package:instagram_clone/features/intro/domain/usecase/read_dark_mode_usecase.dart';
import 'package:instagram_clone/features/intro/domain/usecase/set_dark_mode_usecase.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/intro_bloc.dart';

GetIt locator = GetIt.instance;

void setup() {
  //!intro feature
  //data source
  locator.registerSingleton<IntroLocalDataSource>(IntroLocalDataSourceImpl());
  //repository
  locator.registerSingleton<IntroRepository>(
      IntroRepositoryImpl(introLocalDataSource: locator()));

  //use case
  locator.registerSingleton<CheckConnectionUseCase>(
      CheckConnectionUseCase(introRepository: locator()));

  locator.registerSingleton<SetDarkModeUseCase>(
      SetDarkModeUseCase(introRepository: locator()));

  locator.registerSingleton<ReadDarkModeUseCase>(
      ReadDarkModeUseCase(introRepository: locator()));

  // bloc
  locator.registerSingleton<IntroBloc>(IntroBloc(
    checkConnectionUseCase: locator(),
    readDarkModeUseCase: locator(),
    setDarkModeUseCase: locator(),
  ));
}
