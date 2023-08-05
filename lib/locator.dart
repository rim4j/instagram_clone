import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/intro/data/repository/intro_repository_impl.dart';
import 'package:instagram_clone/features/intro/domain/repository/intro_repository.dart';
import 'package:instagram_clone/features/intro/domain/usecase/check_connection_usecase.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/intro_bloc.dart';

GetIt locator = GetIt.instance;

void setup() {
  //!intro feature
  //repository
  locator.registerSingleton<IntroRepository>(IntroRepositoryImpl());

  //use case
  locator.registerSingleton<CheckConnectionUseCase>(
      CheckConnectionUseCase(introRepository: locator()));

  // bloc
  locator.registerSingleton<IntroBloc>(
      IntroBloc(checkConnectionUseCase: locator()));
}
