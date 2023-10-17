import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';
import 'package:instagram_clone/features/replay/domain/repositories/replay_repositroy.dart';

class UpdateReplayUseCase {
  final ReplayRepository replayRepository;
  UpdateReplayUseCase({
    required this.replayRepository,
  });

  Future<void> call(ReplayEntity replay) {
    return replayRepository.updateReplay(replay);
  }
}
