import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

@immutable
abstract class UsersStatus extends Equatable {}

class UsersInit extends UsersStatus {
  @override
  List<Object?> get props => [];
}

class UsersLoading extends UsersStatus {
  @override
  List<Object?> get props => [];
}

class UsersLoaded extends UsersStatus {
  final List<UserEntity> users;
  UsersLoaded({
    required this.users,
  });
  @override
  List<Object?> get props => [users];
}

class UsersFailed extends UsersStatus {
  @override
  List<Object?> get props => [];
}
