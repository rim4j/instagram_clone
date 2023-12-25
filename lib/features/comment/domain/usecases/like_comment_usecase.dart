import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/repositories/comment_repository.dart';

class LikeCommentUseCase implements UseCase<void, CommentEntity> {
  final CommentRepository commentRepository;

  LikeCommentUseCase({
    required this.commentRepository,
  });
  @override
  Future<void> call({CommentEntity? params}) {
    return commentRepository.likeComment(params!);
  }
}
