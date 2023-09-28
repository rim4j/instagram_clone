import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LikePostStatus extends Equatable {}

class LikePostInit extends LikePostStatus {
  @override
  List<Object?> get props => [];
}

class LikePostLoading extends LikePostStatus {
  @override
  List<Object?> get props => [];
}

class LikePostCompleted extends LikePostStatus {
  @override
  List<Object?> get props => [];
}

class LikePostFailed extends LikePostStatus {
  @override
  List<Object?> get props => [];
}
