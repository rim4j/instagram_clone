import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FollowUnFollowStatus extends Equatable {}

class FollowUnFollowInit extends FollowUnFollowStatus {
  @override
  List<Object?> get props => [];
}

class FollowUnFollowLoading extends FollowUnFollowStatus {
  @override
  List<Object?> get props => [];
}

class FollowUnFollowSuccess extends FollowUnFollowStatus {
  @override
  List<Object?> get props => [];
}

class FollowUnFollowFailed extends FollowUnFollowStatus {
  @override
  List<Object?> get props => [];
}
