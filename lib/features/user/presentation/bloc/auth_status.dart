import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthStatus extends Equatable {}

class AuthInit extends AuthStatus {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthStatus {
  final String uid;
  Authenticated({
    required this.uid,
  });
  @override
  List<Object?> get props => [uid];
}

class Unauthenticated extends AuthStatus {
  @override
  List<Object?> get props => [];
}
