import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecases/like_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecases/read_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecases/update_comment_usecase.dart';
import 'package:instagram_clone/features/comment/presentation/bloc/status/create_comment_status.dart';
import 'package:instagram_clone/features/comment/presentation/bloc/status/delete_comment_status.dart';
import 'package:instagram_clone/features/comment/presentation/bloc/status/like_comment_status.dart';
import 'package:instagram_clone/features/comment/presentation/bloc/status/read_comment_status.dart';
import 'package:instagram_clone/features/comment/presentation/bloc/status/update_comment_status.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CreateCommentUseCase createCommentUseCase;
  DeleteCommentUseCase deleteCommentUseCase;
  LikeCommentUseCase likeCommentUseCase;
  ReadCommentUseCase readCommentUseCase;
  UpdateCommentUseCase updateCommentUseCase;

  CommentBloc({
    required this.createCommentUseCase,
    required this.deleteCommentUseCase,
    required this.likeCommentUseCase,
    required this.readCommentUseCase,
    required this.updateCommentUseCase,
  }) : super(CommentState(
          createCommentStatus: CreateCommentInit(),
          deleteCommentStatus: DeleteCommentInit(),
          likeCommentStatus: LikeCommentInit(),
          readCommentStatus: ReadCommentInit(),
          updateCommentStatus: UpdateCommentInit(),
        )) {
    on<CreateCommentEvent>(_onCreateCommentEvent);
    on<DeleteCommentEvent>(_onDeleteCommentEvent);
    on<LikeCommentEvent>(_onLikeCommentEvent);
    on<ReadCommentEvent>(_onReadCommentEvent);
    on<UpdateCommentEvent>(_onUpdateCommentEvent);
  }

  void _onCreateCommentEvent(
    CreateCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(newCreateCommentStatus: CreateCommentLoading()));

    try {
      await createCommentUseCase(params: event.comment);
      emit(state.copyWith(newCreateCommentStatus: CreateCommentSuccess()));
    } on SocketException catch (_) {
      emit(state.copyWith(newCreateCommentStatus: CreateCommentFailed()));
    } catch (e) {
      emit(state.copyWith(newCreateCommentStatus: CreateCommentFailed()));
    }
  }

  void _onDeleteCommentEvent(
    DeleteCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(newDeleteCommentStatus: DeleteCommentLoading()));
    try {
      await deleteCommentUseCase(params: event.comment);
      emit(state.copyWith(newDeleteCommentStatus: DeleteCommentSuccess()));
    } on SocketException catch (_) {
      emit(state.copyWith(newDeleteCommentStatus: DeleteCommentFailed()));
    } catch (e) {
      emit(state.copyWith(newDeleteCommentStatus: DeleteCommentFailed()));
    }
  }

  void _onLikeCommentEvent(
    LikeCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(newLikeCommentStatus: LikeCommentLoading()));
    try {
      await likeCommentUseCase(params: event.comment);
      emit(state.copyWith(newLikeCommentStatus: LikeCommentSuccess()));
    } on SocketException catch (_) {
      state.copyWith(newLikeCommentStatus: LikeCommentFailed());
    } catch (e) {
      state.copyWith(newLikeCommentStatus: LikeCommentFailed());
    }
  }

  void _onReadCommentEvent(
    ReadCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(newReadCommentStatus: ReadCommentLoading()));

    try {
      final streamRes = readCommentUseCase(params: event.postId);

      await emit.forEach(streamRes, onData: (dynamic data) {
        final List<CommentEntity> comments = data;

        return state.copyWith(
            newReadCommentStatus: ReadCommentSuccess(comments: comments));
      });
    } on SocketException catch (_) {
      state.copyWith(newReadCommentStatus: ReadCommentFailed());
    } catch (e) {
      state.copyWith(newReadCommentStatus: ReadCommentFailed());
    }
  }

  void _onUpdateCommentEvent(
    UpdateCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(newUpdateCommentStatus: UpdateCommentLoading()));
    try {
      await updateCommentUseCase(params: event.comment);
      emit(state.copyWith(newUpdateCommentStatus: UpdateCommentSuccess()));
    } on SocketException catch (_) {
      state.copyWith(newUpdateCommentStatus: UpdateCommentFailed());
    } catch (e) {
      state.copyWith(newUpdateCommentStatus: UpdateCommentFailed());
    }
  }
}
