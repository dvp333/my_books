import 'package:my_books/app/layers/domain/entities/book.dart';

class SearchBooksResult {
  int? totalItems;
  List<Book>? books;

  SearchBooksResult({this.totalItems = 0, this.books = const []});

  SearchBooksResult.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    if (json['items'] != null) {
      books = <Book>[];
      json['items'].forEach((v) {
        books!.add(Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalItems'] = totalItems;
    if (books != null) {
      data['items'] = books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
