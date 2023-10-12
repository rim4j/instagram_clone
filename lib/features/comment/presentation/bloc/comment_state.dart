part of 'comment_bloc.dart';

class CommentState extends Equatable {
  final CreateCommentStatus createCommentStatus;
  final DeleteCommentStatus deleteCommentStatus;
  final LikeCommentStatus likeCommentStatus;
  final ReadCommentStatus readCommentStatus;
  final UpdateCommentStatus updateCommentStatus;
  const CommentState({
    required this.createCommentStatus,
    required this.deleteCommentStatus,
    required this.likeCommentStatus,
    required this.readCommentStatus,
    required this.updateCommentStatus,
  });

  CommentState copyWith({
    CreateCommentStatus? newCreateCommentStatus,
    DeleteCommentStatus? newDeleteCommentStatus,
    LikeCommentStatus? newLikeCommentStatus,
    ReadCommentStatus? newReadCommentStatus,
    UpdateCommentStatus? newUpdateCommentStatus,
  }) {
    return CommentState(
      createCommentStatus: newCreateCommentStatus ?? createCommentStatus,
      deleteCommentStatus: newDeleteCommentStatus ?? deleteCommentStatus,
      likeCommentStatus: newLikeCommentStatus ?? likeCommentStatus,
      readCommentStatus: newReadCommentStatus ?? readCommentStatus,
      updateCommentStatus: newUpdateCommentStatus ?? updateCommentStatus,
    );
  }

  @override
  List<Object?> get props => [
        createCommentStatus,
        deleteCommentStatus,
        likeCommentStatus,
        readCommentStatus,
        updateCommentStatus,
      ];
}
