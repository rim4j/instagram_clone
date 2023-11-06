import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/common/resources/data_state.dart';
import 'package:instagram_clone/features/storage/domain/usecase/upload_cover_image_usecase.dart';
import 'package:instagram_clone/features/storage/domain/usecase/upload_profile_image_usecase.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_single_user_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_users_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/is_sign_in_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/sign_in_user_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/sign_out_user_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/sign_up_user_usecase.dart';
import 'package:instagram_clone/features/user/domain/usecases/update_user_usecase.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/auth_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/credential_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/profile_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/single_user_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/update_profile_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/users_status.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignOutUserUseCase signOutUseCase;

  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  //credentials
  final SignInUserUseCase signInUserUseCase;
  final SignUpUserUseCase signUpUserUseCase;
  final GetUsersUseCase getUsersUseCase;
  final GetSingleUserUseCase singleUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final UploadProfileImageUseCase uploadProfileImageUseCase;
  final UploadCoverImageUseCase uploadCoverImageUseCase;

  UserBloc({
    required this.signOutUseCase,
    required this.isSignInUseCase,
    required this.getCurrentUidUseCase,
    required this.signInUserUseCase,
    required this.signUpUserUseCase,
    required this.singleUserUseCase,
    required this.updateUserUseCase,
    required this.uploadProfileImageUseCase,
    required this.uploadCoverImageUseCase,
    required this.getUsersUseCase,
  }) : super(
          UserState(
            authStatus: AuthInit(),
            credentialStatus: CredentialInit(),
            usersStatus: UsersInit(),
            profileStatus: ProfileInit(),
            updateProfileStatus: UpdateProfileInit(),
            singleUserStatus: SingleUserInit(),
          ),
        ) {
    on<AppStartedEvent>(_onAppStartedEvent);
    // on<LoggedInEvent>(_onLoggedInEvent);
    on<LoggedOutEvent>(_onLoggedOutEvent);
    on<SignInUserEvent>(_onSignInUserEvent);
    on<SignUpUserEvent>(_onSignUpUserEvent);
    on<GetUsersEvent>(_onGetUsersEvent);
    // on<UpdateUserEvent>(_onUpdateUserEvent);
    on<GetProfileEvent>(_onGetProfileEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<UpdateCoverImageEvent>(_onUpdateCoverImageEvent);
    on<UpdateProfileImageEvent>(_onUpdateProfileImageEvent);
    on<GetSingleUserProfile>(_onGetSingleUserProfile);
  }

  void _onAppStartedEvent(
    AppStartedEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      final bool isSignIn = await isSignInUseCase();

      if (isSignIn == true) {
        final uid = await getCurrentUidUseCase();

        emit(state.copyWith(newAuthStatus: Authenticated(uid: uid)));
      } else {
        emit(state.copyWith(newAuthStatus: Unauthenticated()));
      }
    } catch (e) {
      emit(state.copyWith(newAuthStatus: Unauthenticated()));
    }
  }

  void _onLoggedOutEvent(
    LoggedOutEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      await signOutUseCase();
      emit(state.copyWith(newAuthStatus: Unauthenticated()));
      emit(state.copyWith(
          newCredentialStatus:
              CredentialFailed(message: "you has been signed out")));
    } catch (e) {
      emit(state.copyWith(newAuthStatus: Unauthenticated()));
      emit(state.copyWith(
          newCredentialStatus:
              CredentialFailed(message: "you has been signed out")));
    }
  }

  //credentials
  void _onSignInUserEvent(
    SignInUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(newCredentialStatus: CredentialLoading()));

    DataState dataState = await signInUserUseCase(params: event.userEntity);

    if (dataState is DataSuccess) {
      emit(state.copyWith(
          newCredentialStatus: CredentialSuccess(message: dataState.data)));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(
          newCredentialStatus: CredentialFailed(message: dataState.error!)));
    }
  }

  void _onSignUpUserEvent(
    SignUpUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(newCredentialStatus: CredentialLoading()));

    DataState dataState = await signUpUserUseCase(params: event.userEntity);

    if (dataState is DataSuccess) {
      emit(state.copyWith(
          newCredentialStatus: CredentialSuccess(message: dataState.data)));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(
          newCredentialStatus: CredentialFailed(message: dataState.error!)));
    }
  }

  Future<void> _onGetProfileEvent(
    GetProfileEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(newProfileStatus: ProfileLoading()));
    final streamRes = singleUserUseCase(event.uid);

    await emit.forEach(streamRes, onData: (dynamic data) {
      final List<UserEntity> user = data;

      return state.copyWith(newProfileStatus: ProfileSuccess(user: user.first));
    }).catchError((error) {
      emit(state.copyWith(newProfileStatus: ProfileFailed()));
    });
  }

  Future<void> _onGetSingleUserProfile(
    GetSingleUserProfile event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(newSingleUserStatus: SingleUserLoading()));
    final streamRes = singleUserUseCase(event.userUid);

    await emit.forEach(streamRes, onData: (dynamic data) {
      final List<UserEntity> user = data;

      return state.copyWith(
          newSingleUserStatus: SingleUserCompleted(singleUser: user.first));
    }).catchError((error) {
      emit(state.copyWith(newSingleUserStatus: SingleUserFailed()));
    });
  }

  void _onUpdateProfileEvent(
    UpdateProfileEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(newUpdateProfileStatus: UpdateProfileLoading()));
    try {
      await updateUserUseCase(params: event.user);
      emit(state.copyWith(newUpdateProfileStatus: UpdateProfileSuccess()));

      emit(state.copyWith(newUpdateProfileStatus: UpdateProfileSuccess()));
    } on SocketException catch (_) {
      emit(state.copyWith(newUpdateProfileStatus: UpdateProfileFailed()));
    } catch (_) {
      emit(state.copyWith(newUpdateProfileStatus: UpdateProfileFailed()));
    }
  }

  void _onUpdateCoverImageEvent(
    UpdateCoverImageEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(newUpdateProfileStatus: UpdateProfileLoading()));
    try {
      if (event.user.coverFile != null) {
        final String urlCover =
            await uploadCoverImageUseCase(params: event.user.coverFile!);

        await updateUserUseCase(
          params: UserEntity(
            coverUrl: urlCover,
          ),
        );

        emit(state.copyWith(newUpdateProfileStatus: UpdateProfileSuccess()));
      } else {
        return;
      }
    } on SocketException catch (_) {
      emit(state.copyWith(newUpdateProfileStatus: UpdateProfileFailed()));
    } catch (_) {
      emit(state.copyWith(newUpdateProfileStatus: UpdateProfileFailed()));
    }
  }

  void _onUpdateProfileImageEvent(
    UpdateProfileImageEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(newUpdateProfileStatus: UpdateProfileLoading()));
    try {
      if (event.user.imageFile != null) {
        final String profileUrl =
            await uploadProfileImageUseCase(params: event.user.imageFile!);

        await updateUserUseCase(
          params: UserEntity(profileUrl: profileUrl),
        );

        emit(state.copyWith(newUpdateProfileStatus: UpdateProfileSuccess()));
      } else {
        return;
      }
    } on SocketException catch (_) {
      emit(state.copyWith(newUpdateProfileStatus: UpdateProfileFailed()));
    } catch (_) {
      emit(state.copyWith(newUpdateProfileStatus: UpdateProfileFailed()));
    }
  }

  void _onGetUsersEvent(
    GetUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(newUsersStatus: UsersLoading()));
    try {
      final streamRes = getUsersUseCase();

      await emit.forEach(
        streamRes,
        onData: (data) {
          final List<UserEntity> users = data;

          return state.copyWith(newUsersStatus: UsersLoaded(users: users));
        },
      );
    } on SocketException catch (_) {
      emit(state.copyWith(newUsersStatus: UsersFailed()));
    } catch (e) {
      emit(state.copyWith(newUsersStatus: UsersFailed()));
    }
  }

  // void _onUpdateUserEvent(
  //   UpdateUserEvent event,
  //   Emitter<UserState> emit,
  // ) async {
  //  try {

  //  } on SocketException catch (_) {
  //     emit(state.copyWith(newUsersStatus: UsersFailed()));
  //   } catch (e) {
  //     emit(state.copyWith(newUsersStatus: UsersFailed()));
  //   }
  // }
}
