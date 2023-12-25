import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/repositories/comment_repository.dart';

class ReadCommentUseCase implements StreamUseCase<List<CommentEntity>, String> {
  final CommentRepository commentRepository;

  ReadCommentUseCase({
    required this.commentRepository,
  });

  @override
  Stream<List<CommentEntity>> call({String? params}) {
    return commentRepository.readComments(params!);
  }
}
