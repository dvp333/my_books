import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_books/app/injection/injector.dart';
import 'package:my_books/utils/logger/logd.dart';

// -----------------------------------------------------------------------------
// App Bootstrap
// -----------------------------------------------------------------------------

void bootstrap({
  required FutureOr<Widget> Function() appBuilder,
}) {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    logd('Bootstrapping app...');

    await _blockDeviceOrientationToPortrait();
    await _startGetIt();

    runApp(await appBuilder());
  }, (exception, stack) async {
    _logZoneErrorsOnCrashlytics(exception, stack);
  });
}

// -----------------------------------------------------------------------------
// _Helpers
// -----------------------------------------------------------------------------
Future<void> _blockDeviceOrientationToPortrait() {
  return SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

Future<void> _startGetIt() async {
  logd('Inicializando o GetIt...');
  getIt.init();
  await getIt.allReady();
}

void _logZoneErrorsOnCrashlytics(Object exception, StackTrace stack) {
  logd('Erro na inicialização do app: $exception');
  // Este erro seria para o CrashLytics
}
