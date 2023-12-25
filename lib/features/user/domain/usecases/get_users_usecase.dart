import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class GetUsersUseCase implements StreamUseCase<List<UserEntity>, void> {
  final UserRepository userRepository;
  GetUsersUseCase({
    required this.userRepository,
  });

  @override
  Stream<List<UserEntity>> call({void params}) {
    return userRepository.getUsers();
  }
}
