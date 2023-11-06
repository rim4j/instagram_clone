import 'package:instagram_clone/common/resources/data_state.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  Future<DataState<String>> signInUser(UserEntity user);
  Future<DataState<String>> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  Stream<List<UserEntity>> getUsers();
  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);

  Future<void> updateUser(UserEntity user);
}
