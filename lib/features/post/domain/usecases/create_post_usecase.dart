import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class CreatePostUseCase {
  final PostRepository postRepository;
  CreatePostUseCase({
    required this.postRepository,
  });

  Future<void> call(PostEntity post) {
    return postRepository.createPost(post);
  }
}
