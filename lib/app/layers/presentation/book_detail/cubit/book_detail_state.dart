part of 'book_detail_cubit.dart';

@immutable
class BookDetailState {
  final bool isFavorite;
  final String? errorMsg;

  const BookDetailState({required this.isFavorite, this.errorMsg});

  factory BookDetailState.initial() {
    return const BookDetailState(isFavorite: false);
  }

  BookDetailState copyWith({
    bool? isFavorite,
    String? errorMsg,
  }) {
    return BookDetailState(
      isFavorite: isFavorite ?? this.isFavorite,
      errorMsg: errorMsg,
    );
  }
}
