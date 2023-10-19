import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UpdateReplayStatus extends Equatable {}

class UpdateReplayInit extends UpdateReplayStatus {
  @override
  List<Object?> get props => [];
}

class UpdateReplayLoading extends UpdateReplayStatus {
  @override
  List<Object?> get props => [];
}

class UpdateReplaySuccess extends UpdateReplayStatus {
  @override
  List<Object?> get props => [];
}

class UpdateReplayFailed extends UpdateReplayStatus {
  @override
  List<Object?> get props => [];
}
