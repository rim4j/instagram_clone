part of 'replay_bloc.dart';

class ReplayState extends Equatable {
  final CreateReplayStatus createReplayStatus;
  final DeleteReplayStatus deleteReplayStatus;
  final LikeReplayStatus likeReplayStatus;
  final ReadReplaysStatus readReplaysStatus;
  final UpdateReplayStatus updateReplayStatus;

  const ReplayState({
    required this.createReplayStatus,
    required this.deleteReplayStatus,
    required this.likeReplayStatus,
    required this.readReplaysStatus,
    required this.updateReplayStatus,
  });

  ReplayState copyWith({
    CreateReplayStatus? newCreateReplayStatus,
    DeleteReplayStatus? newDeleteReplayStatus,
    LikeReplayStatus? newLikeReplayStatus,
    ReadReplaysStatus? newReadReplaysStatus,
    UpdateReplayStatus? newUpdateReplayStatus,
  }) {
    return ReplayState(
      createReplayStatus: newCreateReplayStatus ?? createReplayStatus,
      deleteReplayStatus: newDeleteReplayStatus ?? deleteReplayStatus,
      likeReplayStatus: newLikeReplayStatus ?? likeReplayStatus,
      readReplaysStatus: newReadReplaysStatus ?? readReplaysStatus,
      updateReplayStatus: newUpdateReplayStatus ?? updateReplayStatus,
    );
  }

  @override
  List<Object?> get props => [
        createReplayStatus,
        deleteReplayStatus,
        likeReplayStatus,
        readReplaysStatus,
        updateReplayStatus,
      ];
}
