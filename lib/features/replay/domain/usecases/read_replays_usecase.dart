import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';
import 'package:instagram_clone/features/replay/domain/repositories/replay_repositroy.dart';

class ReadReplaysUseCase
    implements StreamUseCase<List<ReplayEntity>, ReplayEntity> {
  final ReplayRepository replayRepository;
  ReadReplaysUseCase({
    required this.replayRepository,
  });

  @override
  Stream<List<ReplayEntity>> call({ReplayEntity? params}) {
    return replayRepository.readReplays(params!);
  }
}
