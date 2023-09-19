import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class SignOutUserUseCase implements UseCase<void, void> {
  final UserRepository userRepository;
  SignOutUserUseCase({
    required this.userRepository,
  });

  @override
  Future<void> call({void params}) {
    return userRepository.signOut();
  }
}
