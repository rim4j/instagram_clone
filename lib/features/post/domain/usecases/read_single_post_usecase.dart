import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class ReadSinglePostUseCase implements StreamUseCase<List<PostEntity>, String> {
  final PostRepository postRepository;
  ReadSinglePostUseCase({
    required this.postRepository,
  });
  @override
  Stream<List<PostEntity>> call({String? params}) {
    return postRepository.readSinglePost(params!);
  }
}
