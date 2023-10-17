import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';
import 'package:instagram_clone/features/replay/domain/repositories/replay_repositroy.dart';

class CreateReplayUseCase {
  final ReplayRepository replayRepository;
  CreateReplayUseCase({
    required this.replayRepository,
  });

  Future<void> call(ReplayEntity replay) {
    return replayRepository.createReplay(replay);
  }
}
