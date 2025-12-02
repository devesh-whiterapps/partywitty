// In global_state.dart
import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  static final GlobalState instance = GlobalState._internal();
  factory GlobalState() => instance;
  GlobalState._internal();

  String _videoUrl = '';
  String get videoUrl => _videoUrl;

  set videoUrl(String url) {
    if (_videoUrl != url) {
      _videoUrl = url;
      notifyListeners(); // <-- THIS IS THE KEY
    }
  }
}