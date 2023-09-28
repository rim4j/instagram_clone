import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DeletePostStatus extends Equatable {}

class DeletePostInit extends DeletePostStatus {
  @override
  List<Object?> get props => [];
}

class DeletePostLoading extends DeletePostStatus {
  @override
  List<Object?> get props => [];
}

class DeletePostCompleted extends DeletePostStatus {
  @override
  List<Object?> get props => [];
}

class DeletePostFailed extends DeletePostStatus {
  @override
  List<Object?> get props => [];
}
