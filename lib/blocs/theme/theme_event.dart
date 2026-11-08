import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class SetThemeMode extends ThemeEvent {
  const SetThemeMode(this.mode);

  final ThemeMode mode;

  @override
  List<Object?> get props => [mode];
}

class ToggleThemeMode extends ThemeEvent {
  const ToggleThemeMode();
}
