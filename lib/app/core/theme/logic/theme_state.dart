import 'package:flutter/material.dart';

class ThemeState {
  const ThemeState({required this.primary, required this.secondary});

  final Color primary;
  final Color secondary;

  ThemeState copyWith({Color? primary, Color? secondary}) {
    return ThemeState(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
    );
  }
}
