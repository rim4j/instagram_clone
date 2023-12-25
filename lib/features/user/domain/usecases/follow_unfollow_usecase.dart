import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class FollowUnFollowUseCase implements UseCase<void, UserEntity> {
  final UserRepository userRepository;
  FollowUnFollowUseCase({
    required this.userRepository,
  });

  @override
  Future<void> call({UserEntity? params}) {
    return userRepository.followUnFollowUser(params!);
  }
}
