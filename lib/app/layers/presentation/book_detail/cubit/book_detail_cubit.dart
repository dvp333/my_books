import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/app/layers/domain/entities/book.dart';
import 'package:my_books/app/layers/domain/entities/favorite_books.dart';
import 'package:my_books/app/layers/domain/usecases/base/failure.dart';
import 'package:my_books/app/layers/domain/usecases/get_favorite_books.dart';
import 'package:my_books/app/layers/domain/usecases/save_books_to_favorites.dart';

part 'book_detail_state.dart';

class BookDetailCubit extends Cubit<BookDetailState> {
  BookDetailCubit({
    required SaveBooksToFavorites saveBooksToFavorites,
    required GetFavoriteBooks getFavoriteBooks,
  })  : _saveBooksToFavorites = saveBooksToFavorites,
        _getFavoriteBooks = getFavoriteBooks,
        super(BookDetailState.initial());

  final SaveBooksToFavorites _saveBooksToFavorites;
  final GetFavoriteBooks _getFavoriteBooks;

  void init(Book book) async {
    final favoriteBooksEither = await _getFavoriteBooks();

    final newState = favoriteBooksEither.fold(
      (failure) {
        var msg = failure.toString();
        if (failure is UnexpectedFailure) {
          msg = (failure.error).toString();
        }
        return state.copyWith(errorMsg: msg);
      },
      (favoriteBooks) {
        final books = favoriteBooks.books;
        if (books == null) return state;
        for (final favoriteBook in books) {
          if (favoriteBook.id == book.id) {
            return state.copyWith(isFavorite: true);
          }
        }
        return state;
      },
    );
    emit(newState);
  }

  void changeFavoriteState(Book book) async {
    final newIsFavorite = !state.isFavorite;
    emit(state.copyWith(isFavorite: newIsFavorite));
    final favoriteBooksEither = await _getFavoriteBooks();
    var favoriteBooks = favoriteBooksEither.fold(
      (failure) => <Book>[],
      (favoriteBooks) => favoriteBooks.books,
    );
    var newFavoriteBooks = [...favoriteBooks!];
    if (newIsFavorite) {
      newFavoriteBooks.add(book);
    } else {
      final bookToRemove = favoriteBooks.where((b) => b.id == book.id).first;
      newFavoriteBooks.remove(bookToRemove);
    }
    final either =
        await _saveBooksToFavorites(FavoriteBooks(books: newFavoriteBooks));
    either.fold((failure) => null, (success) => null);
  }
}
