import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DeleteReplayStatus extends Equatable {}

class DeleteReplayInit extends DeleteReplayStatus {
  @override
  List<Object?> get props => [];
}

class DeleteReplayLoading extends DeleteReplayStatus {
  @override
  List<Object?> get props => [];
}

class DeleteReplaySuccess extends DeleteReplayStatus {
  @override
  List<Object?> get props => [];
}

class DeleteReplayFailed extends DeleteReplayStatus {
  @override
  List<Object?> get props => [];
}
