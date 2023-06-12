part of '../injector.dart';

void _initializeDataLayer() {
  _registerDataSources();
  _registerRepositories();
}

void _registerRepositories() {
  getIt.registerFactory<BooksRepository>(
    () => BooksRepositoryImpl(
      remoteDatasource: getIt(),
    ),
  );
}

void _registerDataSources() {
  getIt.registerFactory<RemoteBooksDatasource>(
    () => RemoteBooksDatasourceImpl(),
  );
}
