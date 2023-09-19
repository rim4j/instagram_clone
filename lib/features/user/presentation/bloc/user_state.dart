part of 'user_bloc.dart';

class UserState extends Equatable {
  final AuthStatus authStatus;
  final CredentialStatus credentialStatus;
  final UsersStatus usersStatus;
  final ProfileStatus profileStatus;
  final UpdateProfileStatus updateProfileStatus;

  const UserState({
    required this.authStatus,
    required this.credentialStatus,
    required this.usersStatus,
    required this.profileStatus,
    required this.updateProfileStatus,
  });

  UserState copyWith({
    AuthStatus? newAuthStatus,
    CredentialStatus? newCredentialStatus,
    UsersStatus? newUsersStatus,
    ProfileStatus? newProfileStatus,
    UpdateProfileStatus? newUpdateProfileStatus,
  }) {
    return UserState(
      authStatus: newAuthStatus ?? authStatus,
      credentialStatus: newCredentialStatus ?? credentialStatus,
      usersStatus: newUsersStatus ?? usersStatus,
      profileStatus: newProfileStatus ?? profileStatus,
      updateProfileStatus: newUpdateProfileStatus ?? updateProfileStatus,
    );
  }

  @override
  List<Object?> get props => [
        authStatus,
        credentialStatus,
        usersStatus,
        profileStatus,
        updateProfileStatus,
      ];
}
