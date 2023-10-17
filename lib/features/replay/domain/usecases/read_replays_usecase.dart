import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';
import 'package:instagram_clone/features/replay/domain/repositories/replay_repositroy.dart';

class ReadReplaysUseCase {
  final ReplayRepository replayRepository;
  ReadReplaysUseCase({
    required this.replayRepository,
  });

  Stream<List<ReplayEntity>> call(ReplayEntity replay) {
    return replayRepository.readReplays(replay);
  }
}
