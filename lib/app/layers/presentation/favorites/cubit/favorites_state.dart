part of 'favorites_cubit.dart';

@immutable
class FavoritesState with EquatableMixin {
  final List<Book> books;
  final String? errorMsg;

  const FavoritesState({required this.books, this.errorMsg});

  factory FavoritesState.initial() {
    return const FavoritesState(books: []);
  }

  FavoritesState copyWith({List<Book>? books, String? errorMsg}) {
    return FavoritesState(
      books: books ?? this.books,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [...books, errorMsg];
}
