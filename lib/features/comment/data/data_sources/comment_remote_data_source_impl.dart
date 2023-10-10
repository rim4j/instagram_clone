import 'package:instagram_clone/features/comment/data/data_sources/comment_remote_data_source.dart';
import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  @override
  Future<void> createComment(CommentEntity comment) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteComment(CommentEntity comment) {
    throw UnimplementedError();
  }

  @override
  Future<void> likeComment(CommentEntity comment) {
    throw UnimplementedError();
  }

  @override
  Stream<List<CommentEntity>> readComments(String postId) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateComment(CommentEntity comment) {
    throw UnimplementedError();
  }
}
