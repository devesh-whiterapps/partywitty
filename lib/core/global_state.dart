// In global_state.dart
import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  static final GlobalState instance = GlobalState._internal();
  factory GlobalState() => instance;
  GlobalState._internal();

  String videoUrl = '';

}