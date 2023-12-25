import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class LikePostUseCase implements UseCase<void, PostEntity> {
  final PostRepository postRepository;
  LikePostUseCase({
    required this.postRepository,
  });
  @override
  Future<void> call({PostEntity? params}) {
    return postRepository.likePost(params!);
  }
}
