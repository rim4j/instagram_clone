part of 'post_bloc.dart';

class PostState extends Equatable {
  final PostsStatus postsStatus;
  final CreatePostStatus createPostStatus;
  final UpdatePostStatus updatePostStatus;
  final LikePostStatus likePostStatus;
  final DeletePostStatus deletePostStatus;
  final SinglePostStatus singlePostStatus;

  const PostState({
    required this.postsStatus,
    required this.createPostStatus,
    required this.updatePostStatus,
    required this.likePostStatus,
    required this.deletePostStatus,
    required this.singlePostStatus,
  });

  PostState copyWith({
    PostsStatus? newPostsStatus,
    CreatePostStatus? newCreatePostStatus,
    UpdatePostStatus? newUpdatePostStatus,
    LikePostStatus? newLikePostStatus,
    DeletePostStatus? newDeletePostStatus,
    SinglePostStatus? newSinglePostStatus,
  }) {
    return PostState(
      postsStatus: newPostsStatus ?? postsStatus,
      createPostStatus: newCreatePostStatus ?? createPostStatus,
      updatePostStatus: newUpdatePostStatus ?? updatePostStatus,
      likePostStatus: newLikePostStatus ?? likePostStatus,
      deletePostStatus: newDeletePostStatus ?? deletePostStatus,
      singlePostStatus: newSinglePostStatus ?? singlePostStatus,
    );
  }

  @override
  List<Object?> get props => [
        postsStatus,
        createPostStatus,
        updatePostStatus,
        likePostStatus,
        deletePostStatus,
        singlePostStatus,
      ];
}
