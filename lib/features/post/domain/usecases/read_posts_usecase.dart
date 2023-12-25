import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class ReadPostsUseCase implements StreamUseCase<List<PostEntity>, void> {
  final PostRepository postRepository;
  ReadPostsUseCase({
    required this.postRepository,
  });

  @override
  Stream<List<PostEntity>> call({void params}) {
    return postRepository.readPosts();
  }
}
