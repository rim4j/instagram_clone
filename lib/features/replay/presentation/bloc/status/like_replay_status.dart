import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LikeReplayStatus extends Equatable {}

class LikeReplayInit extends LikeReplayStatus {
  @override
  List<Object?> get props => [];
}

class LikeReplayLoading extends LikeReplayStatus {
  @override
  List<Object?> get props => [];
}

class LikeReplaySuccess extends LikeReplayStatus {
  @override
  List<Object?> get props => [];
}

class LikeReplayFailed extends LikeReplayStatus {
  @override
  List<Object?> get props => [];
}
