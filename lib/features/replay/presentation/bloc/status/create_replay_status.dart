import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CreateReplayStatus extends Equatable {}

class CreateReplayInit extends CreateReplayStatus {
  @override
  List<Object?> get props => [];
}

class CreateReplayLoading extends CreateReplayStatus {
  @override
  List<Object?> get props => [];
}

class CreateReplaySuccess extends CreateReplayStatus {
  @override
  List<Object?> get props => [];
}

class CreateReplayFailed extends CreateReplayStatus {
  @override
  List<Object?> get props => [];
}
