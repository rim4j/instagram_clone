import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

@immutable
abstract class SingleUserStatus extends Equatable {}

class SingleUserInit extends SingleUserStatus {
  @override
  List<Object?> get props => [];
}

class SingleUserLoading extends SingleUserStatus {
  @override
  List<Object?> get props => [];
}

class SingleUserCompleted extends SingleUserStatus {
  final UserEntity singleUser;

  SingleUserCompleted({
    required this.singleUser,
  });

  @override
  List<Object?> get props => [singleUser];
}

class SingleUserFailed extends SingleUserStatus {
  @override
  List<Object?> get props => [];
}
