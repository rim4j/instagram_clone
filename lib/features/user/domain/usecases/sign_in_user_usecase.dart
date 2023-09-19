import 'package:instagram_clone/common/resources/data_state.dart';
import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class SignInUserUseCase implements UseCase<DataState<String>, UserEntity> {
  final UserRepository userRepository;
  SignInUserUseCase({
    required this.userRepository,
  });

  @override
  Future<DataState<String>> call({UserEntity? params}) {
    return userRepository.signInUser(params!);
  }
}
