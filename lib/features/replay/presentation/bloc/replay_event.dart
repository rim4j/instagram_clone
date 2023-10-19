part of 'replay_bloc.dart';

abstract class ReplayEvent extends Equatable {}

class CreateReplayEvent extends ReplayEvent {
  final ReplayEntity replay;
  CreateReplayEvent({
    required this.replay,
  });
  @override
  List<Object?> get props => [replay];
}

class DeleteReplayEvent extends ReplayEvent {
  final ReplayEntity replay;
  DeleteReplayEvent({
    required this.replay,
  });

  @override
  List<Object?> get props => [replay];
}

class LikeReplayEvent extends ReplayEvent {
  final ReplayEntity replay;
  LikeReplayEvent({
    required this.replay,
  });

  @override
  List<Object?> get props => [replay];
}

class ReadReplaysEvent extends ReplayEvent {
  final ReplayEntity replay;
  ReadReplaysEvent({
    required this.replay,
  });

  @override
  List<Object?> get props => [replay];
}

class UpdateReplayEvent extends ReplayEvent {
  final ReplayEntity replay;
  UpdateReplayEvent({
    required this.replay,
  });

  @override
  List<Object?> get props => [replay];
}
