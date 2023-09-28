import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UpdateProfileStatus extends Equatable {}

class UpdateProfileInit extends UpdateProfileStatus {
  @override
  List<Object?> get props => [];
}

class UpdateProfileLoading extends UpdateProfileStatus {
  @override
  List<Object?> get props => [];
}

class UpdateProfileSuccess extends UpdateProfileStatus {
  @override
  List<Object?> get props => [];
}

class UpdateProfileFailed extends UpdateProfileStatus {
  @override
  List<Object?> get props => [];
}
