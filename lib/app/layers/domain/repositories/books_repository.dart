import 'package:my_books/app/layers/domain/entities/search_books_result.dart';
import 'package:my_books/app/layers/domain/usecases/search_books.dart';

abstract class BooksRepository {
  Future<SearchBooksResult> searchBooks(SearchBooksParams param);
}
