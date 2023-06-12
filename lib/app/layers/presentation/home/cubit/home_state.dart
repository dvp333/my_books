part of 'home_cubit.dart';

@immutable
class HomeState {
  final String searchText;
  final SearchBooksResult searchResult;
  final String? errorMessage;
  final bool isLoading;
  final int currentPaginationIndex;
  final List<Item> books;

  const HomeState({
    required this.searchResult,
    required this.searchText,
    required this.isLoading,
    required this.currentPaginationIndex,
    required this.books,
    this.errorMessage,
  });

  factory HomeState.initial() {
    return HomeState(
      searchResult: SearchBooksResult(),
      searchText: '',
      isLoading: false,
      currentPaginationIndex: 0,
      books: const [],
    );
  }

  HomeState copyWith(
      {String? searchText,
      SearchBooksResult? searchResult,
      String? errorMessage,
      bool? isLoading,
      int? currentPaginationIndex,
      List<Item>? books}) {
    return HomeState(
      searchText: searchText ?? this.searchText,
      searchResult: searchResult ?? this.searchResult,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
      currentPaginationIndex:
          currentPaginationIndex ?? this.currentPaginationIndex,
      books: books ?? this.books,
    );
  }
}
