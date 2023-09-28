import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UpdatePostStatus extends Equatable {}

class UpdatePostInit extends UpdatePostStatus {
  @override
  List<Object?> get props => [];
}

class UpdatePostLoading extends UpdatePostStatus {
  @override
  List<Object?> get props => [];
}

class UpdatePostCompleted extends UpdatePostStatus {
  @override
  List<Object?> get props => [];
}

class UpdatePostFailed extends UpdatePostStatus {
  @override
  List<Object?> get props => [];
}
