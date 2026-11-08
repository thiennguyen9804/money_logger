import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.mode});

  final ThemeMode mode;

  @override
  List<Object?> get props => [mode];
}
