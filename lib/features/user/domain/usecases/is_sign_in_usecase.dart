import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class IsSignInUseCase implements UseCase<bool, void> {
  final UserRepository userRepository;
  IsSignInUseCase({
    required this.userRepository,
  });

  @override
  Future<bool> call({void params}) {
    return userRepository.isSignIn();
  }
}
