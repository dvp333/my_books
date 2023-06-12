import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/app/layers/domain/entities/search_books_result.dart';
import 'package:my_books/app/layers/domain/usecases/base/failure.dart';
import 'package:my_books/app/layers/domain/usecases/search_books.dart';
import 'package:my_books/utils/debouncer.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required SearchBooks searchBooks,
  })  : _searchBooks = searchBooks,
        super(HomeState.initial());

  final SearchBooks _searchBooks;
  final _searchDebouncer = Debouncer(milliseconds: 350);

  void searchBook(String text) async {
    if (text == state.searchText) {
      return;
    }

    emit(state.copyWith(
      searchText: text,
      isLoading: true,
    ));

    const minChar = 2;

    if (text.trim().length >= minChar) {
      _searchDebouncer.run(() async {
        if (state.searchText.trim().length >= minChar) {
          loadBooks(text, 0);
        }
      });
    } else {
      emit(HomeState.initial());
    }
  }

  Future<void> loadMoreBooks() async {
    var nextPageIndex =
        state.currentPaginationIndex + SearchBooksParams.maxResults;
    if (nextPageIndex > (state.searchResult.totalItems! - 1)) {
      nextPageIndex = state.searchResult.totalItems! - 1;
    }
    var params = SearchBooksParams(
      currentPaginationIndex: nextPageIndex,
      searchtext: state.searchText,
    );
    var either = await _searchBooks(params);
    final newState = either.fold(
      (failure) {
        var msg = 'Erro: $failure';
        if (failure is UnexpectedFailure) {
          msg = failure.error;
        }
        return state.copyWith(errorMessage: msg);
      },
      (result) => state.copyWith(
          searchResult: result,
          currentPaginationIndex: nextPageIndex,
          books: state.books + result.items!),
    );

    emit(newState.copyWith(isLoading: false));
  }

  Future<void> loadBooks(String text, startIndex) async {
    var params = SearchBooksParams(
      currentPaginationIndex: startIndex,
      searchtext: text,
    );
    var either = await _searchBooks(params);
    final newState = either.fold(
      (failure) {
        var msg = 'Erro: $failure';
        if (failure is UnexpectedFailure) {
          msg = failure.error;
        }
        return state.copyWith(errorMessage: msg);
      },
      (result) => state.copyWith(
        searchText: text,
        searchResult: result,
        books: result.items,
        currentPaginationIndex: startIndex,
      ),
    );

    emit(newState.copyWith(isLoading: false));
  }
}
