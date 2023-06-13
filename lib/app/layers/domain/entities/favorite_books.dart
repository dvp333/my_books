import 'package:my_books/app/layers/domain/entities/book.dart';

class FavoriteBooks {
  List<Book>? books;

  FavoriteBooks({this.books});

  factory FavoriteBooks.empty() {
    return FavoriteBooks(books: const []);
  }

  FavoriteBooks.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      books = <Book>[];
      json['items'].forEach((v) {
        books!.add(Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (books != null) {
      data['items'] = books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
