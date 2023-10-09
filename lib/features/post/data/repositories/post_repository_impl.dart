import 'package:instagram_clone/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  PostRepositoryImpl({
    required this.postRemoteDataSource,
  });
  @override
  Future<void> createPost(PostEntity post) async =>
      postRemoteDataSource.createPost(post);

  @override
  Future<void> deletePost(PostEntity post) async =>
      postRemoteDataSource.deletePost(post);

  @override
  Future<void> likePost(PostEntity post) async =>
      postRemoteDataSource.likePost(post);

  @override
  Stream<List<PostEntity>> readPosts() => postRemoteDataSource.readPosts();

  @override
  Future<void> updatePost(PostEntity post) async =>
      postRemoteDataSource.updatePost(post);

  @override
  Stream<List<PostEntity>> readSinglePost(String postId) =>
      postRemoteDataSource.readSinglePost(postId);
}
