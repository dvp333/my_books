part of '../injector.dart';

void _initializeDomainLayer() {
  getIt.registerLazySingleton(
    () => SearchBooks(
      repository: getIt(),
    ),
  );
}
