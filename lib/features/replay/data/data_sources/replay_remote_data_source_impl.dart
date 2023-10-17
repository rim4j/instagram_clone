import 'package:instagram_clone/features/replay/data/data_sources/replay_remote_data_source.dart';
import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';

class ReplayRemoteDataSourceImpl implements ReplayRemoteDataSource {
  @override
  Future<void> createReplay(ReplayEntity replay) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteReplay(ReplayEntity replay) {
    throw UnimplementedError();
  }

  @override
  Future<void> likeReplay(ReplayEntity replay) {
    throw UnimplementedError();
  }

  @override
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateReplay(ReplayEntity replay) {
    throw UnimplementedError();
  }
}
