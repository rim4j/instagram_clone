import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/usecases/create_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/usecases/delete_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/usecases/like_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/usecases/read_posts_usecase.dart';
import 'package:instagram_clone/features/post/domain/usecases/read_single_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/usecases/update_post_usecase.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/create_post_status.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/delete_post_status.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/like_post_status.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/posts_status.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/single_post_status.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/update_post_status.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final ReadPostsUseCase readPostsUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final CreatePostUseCase createPostUseCase;
  final LikePostUseCase likePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final ReadSinglePostUseCase readSinglePostUseCase;

  PostBloc({
    required this.readPostsUseCase,
    required this.updatePostUseCase,
    required this.createPostUseCase,
    required this.likePostUseCase,
    required this.deletePostUseCase,
    required this.readSinglePostUseCase,
  }) : super(PostState(
          postsStatus: PostsInitial(),
          createPostStatus: CreatePostInitial(),
          deletePostStatus: DeletePostInit(),
          likePostStatus: LikePostInit(),
          updatePostStatus: UpdatePostInit(),
          singlePostStatus: SinglePostInitial(),
        )) {
    on<GetPostsEvent>(_onGetPostsEvent);
    on<GetSinglePostEvent>(_onGetSinglePostEvent);
    on<UpdatePostEvent>(_onUpdatePostEvent);
    on<DeletePostEvent>(_onDeletePostEvent);
    on<LikePostEvent>(_onLikePostEvent);
    on<CreatePostEvent>(_onCreatePostEvent);
  }

  void _onGetPostsEvent(
    GetPostsEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(newPostsStatus: PostsLoading()));

    try {
      final streamRes = readPostsUseCase();

      await emit.forEach(streamRes, onData: (dynamic data) {
        final List<PostEntity> posts = data;

        return state.copyWith(newPostsStatus: PostsCompleted(posts: posts));
      });
    } catch (e) {
      emit(state.copyWith(newPostsStatus: PostsFailed(message: e.toString())));
    }
  }

  void _onGetSinglePostEvent(
    GetSinglePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(newSinglePostStatus: SinglePostLoading()));

    try {
      final streamRes = readSinglePostUseCase(params: event.postId);

      await emit.forEach(streamRes, onData: (dynamic data) {
        final PostEntity? singlePost = data.first;

        if (singlePost != null) {
          print("not empty");
          return state.copyWith(
              newSinglePostStatus: SinglePostCompleted(post: singlePost));
        } else {
          print("empty");
          return state.copyWith(newSinglePostStatus: SinglePostFailed());
        }
      });
    } on SocketException catch (_) {
      emit(state.copyWith(newSinglePostStatus: SinglePostFailed()));
    } catch (_) {
      emit(state.copyWith(newSinglePostStatus: SinglePostFailed()));
    }
  }

  void _onUpdatePostEvent(
    UpdatePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(newUpdatePostStatus: UpdatePostLoading()));
    try {
      await updatePostUseCase(params: event.post);
      emit(state.copyWith(newUpdatePostStatus: UpdatePostCompleted()));
    } on SocketException catch (_) {
      emit(state.copyWith(newUpdatePostStatus: UpdatePostFailed()));
    } catch (_) {
      emit(state.copyWith(newUpdatePostStatus: UpdatePostFailed()));
    }
  }

  void _onDeletePostEvent(
    DeletePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(newDeletePostStatus: DeletePostLoading()));
    try {
      await deletePostUseCase(params: event.post);
      emit(state.copyWith(newDeletePostStatus: DeletePostCompleted()));
    } on SocketException catch (_) {
      emit(state.copyWith(newDeletePostStatus: DeletePostFailed()));
    } catch (_) {
      emit(state.copyWith(newDeletePostStatus: DeletePostFailed()));
    }
  }

  void _onLikePostEvent(
    LikePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(newLikePostStatus: LikePostLoading()));
    try {
      await likePostUseCase(params: event.post);
      emit(state.copyWith(newLikePostStatus: LikePostCompleted()));
    } on SocketException catch (_) {
      emit(state.copyWith(newLikePostStatus: LikePostFailed()));
    } catch (_) {
      emit(state.copyWith(newLikePostStatus: LikePostFailed()));
    }
  }

  void _onCreatePostEvent(
    CreatePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(newCreatePostStatus: CreatePostLoading()));
    try {
      await createPostUseCase(params: event.post);
      emit(state.copyWith(newCreatePostStatus: CreatePostCompleted()));
    } on SocketException catch (_) {
      emit(state.copyWith(newCreatePostStatus: CreatePostFailed()));
    } catch (_) {
      emit(state.copyWith(newCreatePostStatus: CreatePostFailed()));
    }
  }
}
