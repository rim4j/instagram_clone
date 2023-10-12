import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UpdateCommentStatus extends Equatable {}

class UpdateCommentInit extends UpdateCommentStatus {
  @override
  List<Object?> get props => [];
}

class UpdateCommentLoading extends UpdateCommentStatus {
  @override
  List<Object?> get props => [];
}

class UpdateCommentSuccess extends UpdateCommentStatus {
  @override
  List<Object?> get props => [];
}

class UpdateCommentFailed extends UpdateCommentStatus {
  @override
  List<Object?> get props => [];
}
