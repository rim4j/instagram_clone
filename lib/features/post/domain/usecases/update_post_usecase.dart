import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class UpdatePostUseCase {
  final PostRepository postRepository;
  UpdatePostUseCase({
    required this.postRepository,
  });

  Future<void> call(PostEntity post) {
    return postRepository.updatePost(post);
  }
}
