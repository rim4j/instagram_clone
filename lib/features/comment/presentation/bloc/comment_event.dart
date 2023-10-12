// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {}

class CreateCommentEvent extends CommentEvent {
  final CommentEntity comment;

  CreateCommentEvent({
    required this.comment,
  });
  @override
  List<Object?> get props => [comment];
}

class DeleteCommentEvent extends CommentEvent {
  final CommentEntity comment;
  DeleteCommentEvent({
    required this.comment,
  });

  @override
  List<Object?> get props => [comment];
}

class LikeCommentEvent extends CommentEvent {
  final CommentEntity comment;
  LikeCommentEvent({
    required this.comment,
  });

  @override
  List<Object?> get props => [comment];
}

class ReadCommentEvent extends CommentEvent {
  final String postId;

  ReadCommentEvent({
    required this.postId,
  });
  @override
  List<Object?> get props => [postId];
}

class UpdateCommentEvent extends CommentEvent {
  final CommentEntity comment;
  UpdateCommentEvent({
    required this.comment,
  });

  @override
  List<Object?> get props => [comment];
}
