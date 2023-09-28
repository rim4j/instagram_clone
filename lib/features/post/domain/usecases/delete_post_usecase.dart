import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class DeletePostUseCase {
  final PostRepository postRepository;
  DeletePostUseCase({
    required this.postRepository,
  });

  Future<void> call(PostEntity post) {
    return postRepository.deletePost(post);
  }
}
