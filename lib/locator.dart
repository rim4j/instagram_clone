import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/comment/data/data_sources/comment_remote_data_source.dart';
import 'package:instagram_clone/features/comment/data/data_sources/comment_remote_data_source_impl.dart';
import 'package:instagram_clone/features/comment/data/repositories/comment_repository_impl.dart';
import 'package:instagram_clone/features/comment/domain/repositories/comment_repository.dart';
import 'package:instagram_clone/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecases/like_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecases/read_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecases/update_comment_usecase.dart';
import 'package:instagram_clone/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:instagram_clone/features/intro/data/data_source/local/intro_local_data_source.dart';
import 'package:instagram_clone/features/intro/data/data_source/local/intro_local_data_source_impl.dart';
import 'package:instagram_clone/features/intro/data/repository/intro_repository_impl.dart';
import 'package:instagram_clone/features/intro/domain/repository/intro_repository.dart';
import 'package:instagram_clone/features/intro/domain/usecase/check_connection_usecase.dart';
import 'package:instagram_clone/features/intro/domain/usecase/read_dark_mode_usecase.dart';
import 'package:instagram_clone/features/intro/domain/usecase/set_dark_mode_usecase.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:instagram_clone/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:instagram_clone/features/post/data/data_sources/post_remote_data_source_impl.dart';
import 'package:instagram_clone/features/post/data/repositories/post_repository_impl.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';
import 'package:instagram_clone/features/post/domain/usecases/create_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/usecases/delete_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/usecases/like_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/usecases/read_posts_usecase.dart';
import 'package:instagram_clone/features/post/domain/usecases/read_single_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/usecases/update_post_usecase.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/replay/data/data_sources/replay_remote_data_source.dart';
import 'package:instagram_clone/features/replay/data/data_sources/replay_remote_data_source_impl.dart';
import 'package:instagram_clone/features/replay/data/repositories/replay_repository_impl.dart';
import 'package:instagram_clone/features/replay/domain/repositories/replay_repositroy.dart';
import 'package:instagram_clone/features/replay/domain/usecases/create_replay_usecase.dart';
import 'package:instagram_clone/features/replay/domain/usecases/delete_replay_usecase.dart';
import 'package:instagram_clone/features/replay/domain/usecases/like_replay_usecase.dart';
import 'package:instagram_clone/features/replay/domain/usecases/read_replays_usecase.dart';
import 'package:instagram_clone/features/replay/domain/usecases/update_replay_usecase.dart';
import 'package:instagram_clone/features/replay/presentation/bloc/replay_bloc.dart';
import 'package:instagram_clone/features/storage/data/data_source/storage_remote_data_source.dart';
import 'package:instagram_clone/features/storage/data/data_source/storage_remote_data_source_impl.dart';
import 'package:instagram_clone/features/storage/data/repository/storage_repository_impl.dart';
import 'package:instagram_clone/features/storage/domain/repository/storage_repository.dart';
import 'package:instagram_clone/features/storage/domain/usecase/upload_cover_image_usecase.dart';
import 'package:instagram_clone/features/storage/domain/usecase/upload_post_image_usecase.dart';
import 'package:instagram_clone/features/storage/domain/usecase/upload_profile_image_usecase.dart';
import 'package:instagram_clone/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:instagram_clone/features/user/data/data_sources/user_remote_data_source_impl.dart';
import 'package:instagram_clone/features/user/data/repositories/user_repositroy_impl.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';
import 'package:instagram_clone/features/user/domain/usecases/follow_unfollow_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_single_user_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_users_usecase.dart';
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
  locator.registerSingleton<UploadPostImageUseCase>(
    UploadPostImageUseCase(
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

  locator.registerSingleton<GetUsersUseCase>(
      GetUsersUseCase(userRepository: locator()));

  locator.registerSingleton<FollowUnFollowUseCase>(
      FollowUnFollowUseCase(userRepository: locator()));

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
      getUsersUseCase: locator(),
      followUnFollowUseCase: locator(),
    ),
  );

  // <--------------->
  //!post feature

  //data source

  locator.registerSingleton<PostRemoteDataSource>(PostRemoteDataSourceImpl(
    firebaseFirestore: locator(),
    firebaseAuth: locator(),
  ));

  //repository

  locator.registerSingleton<PostRepository>(
      PostRepositoryImpl(postRemoteDataSource: locator()));

  //use case

  locator.registerSingleton<ReadPostsUseCase>(
      ReadPostsUseCase(postRepository: locator()));

  locator.registerSingleton<DeletePostUseCase>(
      DeletePostUseCase(postRepository: locator()));

  locator.registerSingleton<CreatePostUseCase>(
      CreatePostUseCase(postRepository: locator()));

  locator.registerSingleton<LikePostUseCase>(
      LikePostUseCase(postRepository: locator()));

  locator.registerSingleton<UpdatePostUseCase>(
      UpdatePostUseCase(postRepository: locator()));

  locator.registerSingleton<ReadSinglePostUseCase>(
      ReadSinglePostUseCase(postRepository: locator()));

  //bloc
  locator.registerSingleton<PostBloc>(
    PostBloc(
      readPostsUseCase: locator(),
      updatePostUseCase: locator(),
      createPostUseCase: locator(),
      likePostUseCase: locator(),
      deletePostUseCase: locator(),
      readSinglePostUseCase: locator(),
    ),
  );

  // <--------------->
  //!comment feature

  //data source

  locator
      .registerSingleton<CommentRemoteDataSource>(CommentRemoteDataSourceImpl(
    firebaseFirestore: locator(),
    firebaseAuth: locator(),
  ));

  //repository

  locator.registerSingleton<CommentRepository>(
      CommentRepositoryImpl(commentRemoteDataSource: locator()));

  //use case
  locator.registerSingleton<CreateCommentUseCase>(
      CreateCommentUseCase(commentRepository: locator()));

  locator.registerSingleton<DeleteCommentUseCase>(
      DeleteCommentUseCase(commentRepository: locator()));

  locator.registerSingleton<ReadCommentUseCase>(
      ReadCommentUseCase(commentRepository: locator()));

  locator.registerSingleton<UpdateCommentUseCase>(
      UpdateCommentUseCase(commentRepository: locator()));

  locator.registerSingleton<LikeCommentUseCase>(
      LikeCommentUseCase(commentRepository: locator()));

  //bloc

  locator.registerSingleton<CommentBloc>(CommentBloc(
    createCommentUseCase: locator(),
    deleteCommentUseCase: locator(),
    likeCommentUseCase: locator(),
    readCommentUseCase: locator(),
    updateCommentUseCase: locator(),
  ));

  // <--------------->
  //!replay feature

  //data source
  locator.registerSingleton<ReplayRemoteDataSource>(
    ReplayRemoteDataSourceImpl(
      firebaseFirestore: locator(),
      firebaseAuth: locator(),
    ),
  );

  //repository
  locator.registerSingleton<ReplayRepository>(
    ReplayRepositoryImpl(replayRemoteDataSource: locator()),
  );

  //use case
  locator.registerSingleton<CreateReplayUseCase>(
      CreateReplayUseCase(replayRepository: locator()));

  locator.registerSingleton<DeleteReplayUseCase>(
      DeleteReplayUseCase(replayRepository: locator()));

  locator.registerSingleton<LikeReplayUseCase>(
      LikeReplayUseCase(replayRepository: locator()));

  locator.registerSingleton<ReadReplaysUseCase>(
      ReadReplaysUseCase(replayRepository: locator()));

  locator.registerSingleton<UpdateReplayUseCase>(
      UpdateReplayUseCase(replayRepository: locator()));

  //bloc

  locator.registerSingleton<ReplayBloc>(ReplayBloc(
    createReplayUseCase: locator(),
    deleteReplayUseCase: locator(),
    likeReplayUseCase: locator(),
    readReplaysUseCase: locator(),
    updateReplayUseCase: locator(),
  ));
}
