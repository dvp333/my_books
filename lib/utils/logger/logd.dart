import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

// dart:developer.log não possui um limite máximo de caracteres como
// print() ou debugPrint(). É util para exibir informações longas como
// tokens JWT
void logd(String message) {
  if (kReleaseMode) return;

  developer.log(
    '${DateTime.now()} - $message',
    name: 'my_books',
    time: DateTime.now(),
  );
}
