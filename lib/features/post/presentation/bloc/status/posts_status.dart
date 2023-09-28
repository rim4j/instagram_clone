import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';

@immutable
abstract class PostsStatus extends Equatable {}

class PostsInitial extends PostsStatus {
  @override
  List<Object?> get props => [];
}

class PostsLoading extends PostsStatus {
  @override
  List<Object?> get props => [];
}

class PostsCompleted extends PostsStatus {
  final List<PostEntity> posts;

  PostsCompleted({
    required this.posts,
  });
  @override
  List<Object?> get props => [posts];
}

class PostsFailed extends PostsStatus {
  final String message;
  PostsFailed({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}
