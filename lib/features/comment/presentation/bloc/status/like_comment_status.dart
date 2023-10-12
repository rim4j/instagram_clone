import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LikeCommentStatus extends Equatable {}

class LikeCommentInit extends LikeCommentStatus {
  @override
  List<Object?> get props => [];
}

class LikeCommentLoading extends LikeCommentStatus {
  @override
  List<Object?> get props => [];
}

class LikeCommentSuccess extends LikeCommentStatus {
  @override
  List<Object?> get props => [];
}

class LikeCommentFailed extends LikeCommentStatus {
  @override
  List<Object?> get props => [];
}
