// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:instagram_clone/features/comment/data/data_sources/comment_remote_data_source.dart';
import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource commentRemoteDataSource;

  CommentRepositoryImpl({
    required this.commentRemoteDataSource,
  });
  @override
  Future<void> createComment(CommentEntity comment) async =>
      commentRemoteDataSource.createComment(comment);

  @override
  Future<void> deleteComment(CommentEntity comment) async =>
      commentRemoteDataSource.deleteComment(comment);

  @override
  Future<void> likeComment(CommentEntity comment) async =>
      commentRemoteDataSource.likeComment(comment);

  @override
  Stream<List<CommentEntity>> readComments(String postId) =>
      commentRemoteDataSource.readComments(postId);

  @override
  Future<void> updateComment(CommentEntity comment) async =>
      commentRemoteDataSource.updateComment(comment);
}
