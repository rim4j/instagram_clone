import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class ReadPostsUseCase {
  final PostRepository postRepository;
  ReadPostsUseCase({
    required this.postRepository,
  });

  Stream<List<PostEntity>> call() {
    return postRepository.readPosts();
  }
}
