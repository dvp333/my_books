import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int _milliseconds;
  Timer? _timer;

  Debouncer({required int milliseconds}) : _milliseconds = milliseconds;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: _milliseconds), action);
  }
}
