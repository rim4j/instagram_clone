import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/repositories/comment_repository.dart';

class LikeCommentUseCase {
  final CommentRepository commentRepository;

  LikeCommentUseCase({
    required this.commentRepository,
  });

  Future<void> call(CommentEntity comment) {
    return commentRepository.likeComment(comment);
  }
}
