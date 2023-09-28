import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CreatePostStatus extends Equatable {}

class CreatePostInitial extends CreatePostStatus {
  @override
  List<Object?> get props => [];
}

class CreatePostLoading extends CreatePostStatus {
  @override
  List<Object?> get props => [];
}

class CreatePostCompleted extends CreatePostStatus {
  @override
  List<Object?> get props => [];
}

class CreatePostFailed extends CreatePostStatus {
  @override
  List<Object?> get props => [];
}
