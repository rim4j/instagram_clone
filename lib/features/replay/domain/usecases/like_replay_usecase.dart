import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';
import 'package:instagram_clone/features/replay/domain/repositories/replay_repositroy.dart';

class LikeReplayUseCase implements UseCase<void, ReplayEntity> {
  final ReplayRepository replayRepository;
  LikeReplayUseCase({
    required this.replayRepository,
  });

  @override
  Future<void> call({ReplayEntity? params}) {
    return replayRepository.likeReplay(params!);
  }
}
