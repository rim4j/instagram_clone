import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class FollowUnFollowUseCase {
  final UserRepository userRepository;
  FollowUnFollowUseCase({
    required this.userRepository,
  });

  Future<void> call(UserEntity user) {
    return userRepository.followUnFollowUser(user);
  }
}
