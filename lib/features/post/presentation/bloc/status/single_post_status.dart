// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';

@immutable
abstract class SinglePostStatus extends Equatable {}

class SinglePostInitial extends SinglePostStatus {
  @override
  List<Object?> get props => [];
}

class SinglePostLoading extends SinglePostStatus {
  @override
  List<Object?> get props => [];
}

class SinglePostCompleted extends SinglePostStatus {
  final PostEntity post;

  SinglePostCompleted({
    required this.post,
  });

  @override
  List<Object?> get props => [post];
}

class SinglePostFailed extends SinglePostStatus {
  @override
  List<Object?> get props => [];
}
