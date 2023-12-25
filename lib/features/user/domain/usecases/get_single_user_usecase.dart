import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class GetSingleUserUseCase implements StreamUseCase<List<UserEntity>, String> {
  final UserRepository userRepository;
  GetSingleUserUseCase({
    required this.userRepository,
  });

  @override
  Stream<List<UserEntity>> call({String? params}) {
    return userRepository.getSingleUser(params!);
  }
}
