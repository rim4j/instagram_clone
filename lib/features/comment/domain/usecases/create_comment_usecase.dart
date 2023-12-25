import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/repositories/comment_repository.dart';

class CreateCommentUseCase implements UseCase<void, CommentEntity> {
  final CommentRepository commentRepository;

  CreateCommentUseCase({
    required this.commentRepository,
  });

  @override
  Future<void> call({CommentEntity? params}) {
    return commentRepository.createComment(params!);
  }
}
