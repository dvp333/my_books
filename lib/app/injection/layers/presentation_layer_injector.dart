part of '../injector.dart';

void _initializePresentationLayer() {
  getIt
    ..registerLazySingleton(() => HomeCubit(
          searchBooks: getIt(),
        ))
    ..registerFactory(() => BookDetailCubit(
          getFavoriteBooks: getIt(),
          saveBooksToFavorites: getIt(),
        ));
}
