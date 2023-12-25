import 'dart:io';

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
  _onCreateReplayEvent(
    CreateReplayEvent event,
    Emitter<ReplayState> emit,
  ) async {
    emit(state.copyWith(newCreateReplayStatus: CreateReplayLoading()));

    try {
      await createReplayUseCase(params: event.replay);
      emit(state.copyWith(newCreateReplayStatus: CreateReplaySuccess()));
    } on SocketException catch (_) {
      emit(state.copyWith(newCreateReplayStatus: CreateReplayFailed()));
    } catch (e) {
      emit(state.copyWith(newCreateReplayStatus: CreateReplayFailed()));
    }
  }

  _onDeleteReplayEvent(
    DeleteReplayEvent event,
    Emitter<ReplayState> emit,
  ) async {
    emit(state.copyWith(newDeleteReplayStatus: DeleteReplayLoading()));

    try {
      await deleteReplayUseCase(params: event.replay);
      emit(state.copyWith(newDeleteReplayStatus: DeleteReplaySuccess()));
    } on SocketException catch (_) {
      emit(state.copyWith(newDeleteReplayStatus: DeleteReplayFailed()));
    } catch (e) {
      emit(state.copyWith(newDeleteReplayStatus: DeleteReplayFailed()));
    }
  }

  _onLikeReplayEvent(
    LikeReplayEvent event,
    Emitter<ReplayState> emit,
  ) async {
    emit(state.copyWith(newLikeReplayStatus: LikeReplayLoading()));

    try {
      await likeReplayUseCase(params: event.replay);
      emit(state.copyWith(newLikeReplayStatus: LikeReplaySuccess()));
    } on SocketException catch (_) {
      emit(state.copyWith(newLikeReplayStatus: LikeReplayFailed()));
    } catch (e) {
      emit(state.copyWith(newLikeReplayStatus: LikeReplayFailed()));
    }
  }

  _onReadReplaysEvent(
    ReadReplaysEvent event,
    Emitter<ReplayState> emit,
  ) async {
    emit(state.copyWith(newReadReplaysStatus: ReadReplaysLoading()));

    try {
      final streamRes = readReplaysUseCase(params: event.replay);

      await emit.forEach(streamRes, onData: (dynamic data) {
        final List<ReplayEntity> replays = data;

        return state.copyWith(
            newReadReplaysStatus: ReadReplaysSuccess(replays: replays));
      });
    } on SocketException catch (_) {
      emit(state.copyWith(newReadReplaysStatus: ReadReplaysFailed()));
    } catch (e) {
      emit(state.copyWith(newReadReplaysStatus: ReadReplaysFailed()));
    }
  }

  _onUpdateReplayEvent(
    UpdateReplayEvent event,
    Emitter<ReplayState> emit,
  ) async {
    emit(state.copyWith(newUpdateReplayStatus: UpdateReplaySuccess()));

    try {
      await updateReplayUseCase(params: event.replay);
      emit(state.copyWith(newUpdateReplayStatus: UpdateReplaySuccess()));
    } on SocketException catch (_) {
      emit(state.copyWith(newUpdateReplayStatus: UpdateReplayFailed()));
    } catch (e) {
      emit(state.copyWith(newUpdateReplayStatus: UpdateReplayFailed()));
    }
  }
}
