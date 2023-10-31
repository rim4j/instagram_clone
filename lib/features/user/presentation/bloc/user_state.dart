part of 'user_bloc.dart';

class UserState extends Equatable {
  final AuthStatus authStatus;
  final CredentialStatus credentialStatus;
  final UsersStatus usersStatus;
  final ProfileStatus profileStatus;
  final UpdateProfileStatus updateProfileStatus;
  final SingleUserStatus singleUserStatus;

  const UserState({
    required this.authStatus,
    required this.credentialStatus,
    required this.usersStatus,
    required this.profileStatus,
    required this.updateProfileStatus,
    required this.singleUserStatus,
  });

  UserState copyWith({
    AuthStatus? newAuthStatus,
    CredentialStatus? newCredentialStatus,
    UsersStatus? newUsersStatus,
    ProfileStatus? newProfileStatus,
    UpdateProfileStatus? newUpdateProfileStatus,
    SingleUserStatus? newSingleUserStatus,
  }) {
    return UserState(
      authStatus: newAuthStatus ?? authStatus,
      credentialStatus: newCredentialStatus ?? credentialStatus,
      usersStatus: newUsersStatus ?? usersStatus,
      profileStatus: newProfileStatus ?? profileStatus,
      updateProfileStatus: newUpdateProfileStatus ?? updateProfileStatus,
      singleUserStatus: newSingleUserStatus ?? singleUserStatus,
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
      ];
}
