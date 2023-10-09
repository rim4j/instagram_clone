part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {}

class GetPostsEvent extends PostEvent {
  @override
  List<Object?> get props => [];
}

class UpdatePostEvent extends PostEvent {
  final PostEntity post;

  UpdatePostEvent({
    required this.post,
  });
  @override
  List<Object?> get props => [post];
}

class DeletePostEvent extends PostEvent {
  final PostEntity post;

  DeletePostEvent({
    required this.post,
  });
  @override
  List<Object?> get props => [post];
}

class LikePostEvent extends PostEvent {
  final PostEntity post;

  LikePostEvent({
    required this.post,
  });
  @override
  List<Object?> get props => [post];
}

class CreatePostEvent extends PostEvent {
  final PostEntity post;

  CreatePostEvent({
    required this.post,
  });
  @override
  List<Object?> get props => [post];
}

class GetSinglePostEvent extends PostEvent {
  final String postId;

  GetSinglePostEvent({
    required this.postId,
  });
  @override
  List<Object?> get props => [postId];
}
