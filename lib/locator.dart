import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/intro/data/data_source/local/intro_local_data_source.dart';
import 'package:instagram_clone/features/intro/data/data_source/local/intro_local_data_source_impl.dart';
import 'package:instagram_clone/features/intro/data/repository/intro_repository_impl.dart';
import 'package:instagram_clone/features/intro/domain/repository/intro_repository.dart';
import 'package:instagram_clone/features/intro/domain/usecase/check_connection_usecase.dart';
import 'package:instagram_clone/features/intro/domain/usecase/read_dark_mode_usecase.dart';
import 'package:instagram_clone/features/intro/domain/usecase/set_dark_mode_usecase.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:instagram_clone/features/storage/data/data_source/storage_remote_data_source.dart';
import 'package:instagram_clone/features/storage/data/data_source/storage_remote_data_source_impl.dart';
import 'package:instagram_clone/features/storage/data/repository/storage_repository_impl.dart';
import 'package:instagram_clone/features/storage/domain/repository/storage_repository.dart';
import 'package:instagram_clone/features/storage/domain/usecase/upload_cover_image_usecase.dart';
import 'package:instagram_clone/features/storage/domain/usecase/upload_profile_image_usecase.dart';
import 'package:instagram_clone/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:instagram_clone/features/user/data/data_sources/user_remote_data_source_impl.dart';
import 'package:instagram_clone/features/user/data/repositories/user_repositroy_impl.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_single_user_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/is_sign_in_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/sign_in_user_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/sign_out_user_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/sign_up_user_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/update_user_usecase.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';

GetIt locator = GetIt.instance;

void setup() {
  //!firebase
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  locator.registerLazySingleton(() => auth);
  locator.registerLazySingleton(() => fireStore);
  locator.registerLazySingleton(() => firebaseStorage);

  // <--------------->
  //!storage feature

  //data source
  locator.registerSingleton<StorageRemoteDataSource>(
    StorageRemoteDataSourceImpl(
      firebaseStorage: locator(),
      firebaseAuth: locator(),
    ),
  );
  //repository
  locator.registerSingleton<StorageRepository>(
    StorageRepositoryImpl(
      storageRemoteDataSource: locator(),
    ),
  );
  //use case
  locator.registerSingleton<UploadProfileImageUseCase>(
    UploadProfileImageUseCase(
      storageRepository: locator(),
    ),
  );
  locator.registerSingleton<UploadCoverImageUseCase>(
    UploadCoverImageUseCase(
      storageRepository: locator(),
    ),
  );

  // <--------------->
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

  // <--------------->
  //!user feature

  //data source
  locator.registerSingleton<UserRemoteDataSource>(
    UserRemoteDataSourceImpl(
      firebaseFirestore: locator(),
      firebaseAuth: locator(),
    ),
  );

  //repository
  locator.registerSingleton<UserRepository>(
      UserRepositoryImpl(userRemoteDataSource: locator()));

  //use case
  locator.registerSingleton<SignUpUserUseCase>(
      SignUpUserUseCase(userRepository: locator()));

  locator.registerSingleton<SignInUserUseCase>(
      SignInUserUseCase(userRepository: locator()));

  locator.registerSingleton<IsSignInUseCase>(
      IsSignInUseCase(userRepository: locator()));

  locator.registerSingleton<GetCurrentUidUseCase>(
      GetCurrentUidUseCase(userRepository: locator()));

  locator.registerSingleton<SignOutUserUseCase>(
      SignOutUserUseCase(userRepository: locator()));

  locator.registerSingleton<GetSingleUserUseCase>(
      GetSingleUserUseCase(userRepository: locator()));

  locator.registerSingleton<UpdateUserUseCase>(
      UpdateUserUseCase(userRepository: locator()));

  //bloc
  locator.registerSingleton<UserBloc>(
    UserBloc(
      signInUserUseCase: locator(),
      signUpUserUseCase: locator(),
      getCurrentUidUseCase: locator(),
      isSignInUseCase: locator(),
      signOutUseCase: locator(),
      singleUserUseCase: locator(),
      updateUserUseCase: locator(),
      uploadProfileImageUseCase: locator(),
      uploadCoverImageUseCase: locator(),
    ),
  );
}
