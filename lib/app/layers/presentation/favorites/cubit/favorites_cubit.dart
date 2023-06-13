import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/app/layers/domain/entities/book.dart';
import 'package:my_books/app/layers/domain/usecases/base/failure.dart';
import 'package:my_books/app/layers/domain/usecases/get_favorite_books.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required GetFavoriteBooks getFavoriteBooks})
      : _getFavoriteBooks = getFavoriteBooks,
        super(FavoritesState.initial());

  final GetFavoriteBooks _getFavoriteBooks;

  void init() async {
    final favoriteBooksEither = await _getFavoriteBooks();

    final newState = favoriteBooksEither.fold(
      (failure) {
        var msg = failure.toString();
        if (failure is UnexpectedFailure) {
          msg = (failure.error).toString();
        }
        return state.copyWith(
          books: [],
          errorMsg: msg,
        );
      },
      (favoriteBooks) {
        final books = favoriteBooks.books;
        return state.copyWith(books: books);
      },
    );
    emit(newState);
  }
}
