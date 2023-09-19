import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class GetCurrentUidUseCase implements UseCase<String, void> {
  final UserRepository userRepository;
  GetCurrentUidUseCase({
    required this.userRepository,
  });

  @override
  Future<String> call({void params}) {
    return userRepository.getCurrentUid();
  }
}
