import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository userRepository;
  GetUsersUseCase({
    required this.userRepository,
  });

  Stream<List<UserEntity>> call(UserEntity user) {
    return userRepository.getUsers(user);
  }
}
