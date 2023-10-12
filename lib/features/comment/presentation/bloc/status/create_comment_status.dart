import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CreateCommentStatus extends Equatable {}

class CreateCommentInit extends CreateCommentStatus {
  @override
  List<Object?> get props => [];
}

class CreateCommentLoading extends CreateCommentStatus {
  @override
  List<Object?> get props => [];
}

class CreateCommentSuccess extends CreateCommentStatus {
  @override
  List<Object?> get props => [];
}

class CreateCommentFailed extends CreateCommentStatus {
  @override
  List<Object?> get props => [];
}
