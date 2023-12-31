part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {}

class AppStartedEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class LoggedOutEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class SignInUserEvent extends UserEvent {
  final UserEntity userEntity;

  SignInUserEvent({
    required this.userEntity,
  });

  @override
  List<Object?> get props => [userEntity];
}

class SignUpUserEvent extends UserEvent {
  final UserEntity userEntity;
  SignUpUserEvent({
    required this.userEntity,
  });
  @override
  List<Object?> get props => [userEntity];
}

class GetUsersEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class UpdateUserEvent extends UserEvent {
  final UserEntity userEntity;
  UpdateUserEvent({
    required this.userEntity,
  });
  @override
  List<Object?> get props => [userEntity];
}

class GetProfileEvent extends UserEvent {
  final String uid;
  GetProfileEvent({
    required this.uid,
  });
  @override
  List<Object?> get props => [uid];
}

class UpdateProfileEvent extends UserEvent {
  final UserEntity user;
  UpdateProfileEvent({required this.user});
  @override
  List<Object?> get props => [user];
}

class UpdateCoverImageEvent extends UserEvent {
  final UserEntity user;
  UpdateCoverImageEvent({required this.user});
  @override
  List<Object?> get props => [user];
}

class UpdateProfileImageEvent extends UserEvent {
  final UserEntity user;
  UpdateProfileImageEvent({required this.user});
  @override
  List<Object?> get props => [user];
}

class GetSingleUserProfileEvent extends UserEvent {
  final String userUid;
  GetSingleUserProfileEvent({required this.userUid});
  @override
  List<Object?> get props => [userUid];
}

class GetFollowUnFollowEvent extends UserEvent {
  final UserEntity user;
  GetFollowUnFollowEvent({required this.user});
  @override
  List<Object?> get props => [user];
}
