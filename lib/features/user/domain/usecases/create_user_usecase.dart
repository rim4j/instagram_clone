import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository userRepository;
  CreateUserUseCase({
    required this.userRepository,
  });

  Future<void> call(UserEntity user) {
    return userRepository.createUser(user);
  }
}
