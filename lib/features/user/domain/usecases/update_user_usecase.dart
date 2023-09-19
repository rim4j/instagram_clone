import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class UpdateUserUseCase implements UseCase<void, UserEntity> {
  final UserRepository userRepository;

  UpdateUserUseCase({
    required this.userRepository,
  });

  @override
  Future<void> call({UserEntity? params}) {
    return userRepository.updateUser(params!);
  }
}
