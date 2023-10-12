import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DeleteCommentStatus extends Equatable {}

class DeleteCommentInit extends DeleteCommentStatus {
  @override
  List<Object?> get props => [];
}

class DeleteCommentLoading extends DeleteCommentStatus {
  @override
  List<Object?> get props => [];
}

class DeleteCommentSuccess extends DeleteCommentStatus {
  @override
  List<Object?> get props => [];
}

class DeleteCommentFailed extends DeleteCommentStatus {
  @override
  List<Object?> get props => [];
}
