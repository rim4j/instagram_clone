import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/repositories/comment_repository.dart';

class ReadCommentUseCase {
  final CommentRepository commentRepository;

  ReadCommentUseCase({
    required this.commentRepository,
  });

  Stream<List<CommentEntity>> call(String postId) {
    return commentRepository.readComments(postId);
  }
}
