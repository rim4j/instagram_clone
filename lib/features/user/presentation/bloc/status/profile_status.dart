import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

@immutable
abstract class ProfileStatus extends Equatable {}

class ProfileInit extends ProfileStatus {
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileStatus {
  @override
  List<Object?> get props => [];
}

class ProfileSuccess extends ProfileStatus {
  final UserEntity user;

  ProfileSuccess({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class ProfileFailed extends ProfileStatus {
  @override
  List<Object?> get props => [];
}
