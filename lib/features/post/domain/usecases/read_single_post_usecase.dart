import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class ReadSinglePostUseCase {
  final PostRepository postRepository;
  ReadSinglePostUseCase({
    required this.postRepository,
  });

  Stream<List<PostEntity>> call(String postId) {
    return postRepository.readSinglePost(postId);
  }
}
