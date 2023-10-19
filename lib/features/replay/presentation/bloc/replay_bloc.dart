import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';
import 'package:instagram_clone/features/replay/domain/usecases/create_replay_usecase.dart';
import 'package:instagram_clone/features/replay/domain/usecases/delete_replay_usecase.dart';
import 'package:instagram_clone/features/replay/domain/usecases/like_replay_usecase.dart';
import 'package:instagram_clone/features/replay/domain/usecases/read_replays_usecase.dart';
import 'package:instagram_clone/features/replay/domain/usecases/update_replay_usecase.dart';
import 'package:instagram_clone/features/replay/presentation/bloc/status/create_replay_status.dart';
import 'package:instagram_clone/features/replay/presentation/bloc/status/delete_replay_status.dart';
import 'package:instagram_clone/features/replay/presentation/bloc/status/like_replay_status.dart';
import 'package:instagram_clone/features/replay/presentation/bloc/status/read_replays_status.dart';
import 'package:instagram_clone/features/replay/presentation/bloc/status/update_replay_status.dart';

part 'replay_event.dart';
part 'replay_state.dart';

class ReplayBloc extends Bloc<ReplayEvent, ReplayState> {
  final CreateReplayUseCase createReplayUseCase;
  final DeleteReplayUseCase deleteReplayUseCase;
  final LikeReplayUseCase likeReplayUseCase;
  final ReadReplaysUseCase readReplaysUseCase;
  final UpdateReplayUseCase updateReplayUseCase;

  ReplayBloc({
    required this.createReplayUseCase,
    required this.deleteReplayUseCase,
    required this.likeReplayUseCase,
    required this.readReplaysUseCase,
    required this.updateReplayUseCase,
  }) : super(
          ReplayState(
            createReplayStatus: CreateReplayInit(),
            deleteReplayStatus: DeleteReplayInit(),
            likeReplayStatus: LikeReplayInit(),
            readReplaysStatus: ReadReplaysInit(),
            updateReplayStatus: UpdateReplayInit(),
          ),
        ) {
    on<CreateReplayEvent>(_onCreateReplayEvent);
    on<DeleteReplayEvent>(_onDeleteReplayEvent);
    on<LikeReplayEvent>(_onLikeReplayEvent);
    on<ReadReplaysEvent>(_onReadReplaysEvent);
    on<UpdateReplayEvent>(_onUpdateReplayEvent);
  }
  _onCreateReplayEvent(CreateReplayEvent event, Emitter<ReplayState> emit) {}
  _onDeleteReplayEvent(DeleteReplayEvent event, Emitter<ReplayState> emit) {}
  _onLikeReplayEvent(LikeReplayEvent event, Emitter<ReplayState> emit) {}
  _onReadReplaysEvent(ReadReplaysEvent event, Emitter<ReplayState> emit) {}
  _onUpdateReplayEvent(UpdateReplayEvent event, Emitter<ReplayState> emit) {}
}
