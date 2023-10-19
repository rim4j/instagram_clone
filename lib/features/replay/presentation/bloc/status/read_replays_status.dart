import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';

@immutable
abstract class ReadReplaysStatus extends Equatable {}

class ReadReplaysInit extends ReadReplaysStatus {
  @override
  List<Object?> get props => [];
}

class ReadReplaysLoading extends ReadReplaysStatus {
  @override
  List<Object?> get props => [];
}

class ReadReplaysSuccess extends ReadReplaysStatus {
  final List<ReplayEntity> replays;

  ReadReplaysSuccess({
    required this.replays,
  });

  @override
  List<Object?> get props => [replays];
}

class ReadReplaysFailed extends ReadReplaysStatus {
  @override
  List<Object?> get props => [];
}
