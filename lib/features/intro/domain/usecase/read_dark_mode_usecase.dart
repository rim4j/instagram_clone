import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/intro/domain/repository/intro_repository.dart';

class ReadDarkModeUseCase implements UseCase<void, bool> {
  final IntroRepository introRepository;

  ReadDarkModeUseCase({
    required this.introRepository,
  });

  @override
  Future<bool> call({void params}) async =>
      await introRepository.readDarkMode();
}
