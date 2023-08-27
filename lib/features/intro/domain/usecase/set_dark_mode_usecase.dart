import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/intro/domain/repository/intro_repository.dart';

class SetDarkModeUseCase implements UseCase<void, bool> {
  final IntroRepository introRepository;
  SetDarkModeUseCase({
    required this.introRepository,
  });

  @override
  Future<void> call({bool? params}) async {
    return await introRepository.setDarkMode(params!);
  }
}
