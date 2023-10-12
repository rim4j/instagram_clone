import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';

@immutable
abstract class ReadCommentStatus extends Equatable {}

class ReadCommentInit extends ReadCommentStatus {
  @override
  List<Object?> get props => [];
}

class ReadCommentLoading extends ReadCommentStatus {
  @override
  List<Object?> get props => [];
}

class ReadCommentSuccess extends ReadCommentStatus {
  final List<CommentEntity> comments;

  ReadCommentSuccess({
    required this.comments,
  });
  @override
  List<Object?> get props => [comments];
}

class ReadCommentFailed extends ReadCommentStatus {
  @override
  List<Object?> get props => [];
}
