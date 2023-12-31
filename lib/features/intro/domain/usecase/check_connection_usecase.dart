import 'package:instagram_clone/common/resources/data_state.dart';
import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/intro/domain/repository/intro_repository.dart';

class CheckConnectionUseCase implements UseCase<DataState<bool>, void> {
  final IntroRepository introRepository;

  CheckConnectionUseCase({
    required this.introRepository,
  });
  @override
  Future<DataState<bool>> call({void params}) {
    return introRepository.checkConnection();
  }
}
