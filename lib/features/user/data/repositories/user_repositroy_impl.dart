import 'package:instagram_clone/common/resources/data_state.dart';
import 'package:instagram_clone/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  UserRepositoryImpl({
    required this.userRemoteDataSource,
  });

  @override
  Future<void> createUser(UserEntity user) async =>
      userRemoteDataSource.createUser(user);

  @override
  Future<String> getCurrentUid() async => userRemoteDataSource.getCurrentUid();

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) =>
      userRemoteDataSource.getSingleUser(uid);

  @override
  Stream<List<UserEntity>> getUsers() => userRemoteDataSource.getUsers();

  @override
  Future<bool> isSignIn() async => userRemoteDataSource.isSignIn();

  @override
  Future<DataState<String>> signInUser(UserEntity user) async =>
      userRemoteDataSource.signInUser(user);

  @override
  Future<void> signOut() async => userRemoteDataSource.signOut();

  @override
  Future<DataState<String>> signUpUser(UserEntity user) async =>
      userRemoteDataSource.signUpUser(user);

  @override
  Future<void> updateUser(UserEntity user) async =>
      userRemoteDataSource.updateUser(user);

  @override
  Future<void> followUnFollowUser(UserEntity user) async =>
      userRemoteDataSource.followUnFollowUser(user);
}
