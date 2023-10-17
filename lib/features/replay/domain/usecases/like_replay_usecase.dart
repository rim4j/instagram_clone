import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';
import 'package:instagram_clone/features/replay/domain/repositories/replay_repositroy.dart';

class LikeReplayUseCase {
  final ReplayRepository replayRepository;
  LikeReplayUseCase({
    required this.replayRepository,
  });

  Future<void> call(ReplayEntity replay) {
    return replayRepository.likeReplay(replay);
  }
}
