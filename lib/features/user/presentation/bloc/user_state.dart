part of 'user_bloc.dart';

class UserState extends Equatable {
  final AuthStatus authStatus;
  final CredentialStatus credentialStatus;
  final UsersStatus usersStatus;
  final ProfileStatus profileStatus;
  final UpdateProfileStatus updateProfileStatus;
  final SingleUserStatus singleUserStatus;
  final FollowUnFollowStatus followUnFollowStatus;

  const UserState({
    required this.authStatus,
    required this.credentialStatus,
    required this.usersStatus,
    required this.profileStatus,
    required this.updateProfileStatus,
    required this.singleUserStatus,
    required this.followUnFollowStatus,
  });

  UserState copyWith({
    AuthStatus? newAuthStatus,
    CredentialStatus? newCredentialStatus,
    UsersStatus? newUsersStatus,
    ProfileStatus? newProfileStatus,
    UpdateProfileStatus? newUpdateProfileStatus,
    SingleUserStatus? newSingleUserStatus,
    FollowUnFollowStatus? newFollowUnFollowStatus,
  }) {
    return UserState(
      authStatus: newAuthStatus ?? authStatus,
      credentialStatus: newCredentialStatus ?? credentialStatus,
      usersStatus: newUsersStatus ?? usersStatus,
      profileStatus: newProfileStatus ?? profileStatus,
      updateProfileStatus: newUpdateProfileStatus ?? updateProfileStatus,
      singleUserStatus: newSingleUserStatus ?? singleUserStatus,
      followUnFollowStatus: newFollowUnFollowStatus ?? followUnFollowStatus,
    );
  }

  @override
  List<Object?> get props => [
        authStatus,
        credentialStatus,
        usersStatus,
        profileStatus,
        updateProfileStatus,
        singleUserStatus,
        followUnFollowStatus,
      ];
}
