import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';

abstract class CommentRemoteDataSource {
  Future<void> createComment(CommentEntity comment);
  Stream<List<CommentEntity>> readComments(String postId);
  Future<void> updateComment(CommentEntity comment);
  Future<void> deleteComment(CommentEntity comment);
  Future<void> likeComment(CommentEntity comment);
}
