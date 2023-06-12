import 'package:my_books/app/layers/data/datasources/remote/remote_books_datasource.dart';
import 'package:my_books/app/layers/domain/entities/search_books_result.dart';
import 'package:my_books/app/layers/domain/repositories/books_repository.dart';
import 'package:my_books/app/layers/domain/usecases/search_books.dart';

class BooksRepositoryImpl implements BooksRepository {
  BooksRepositoryImpl({
    required RemoteBooksDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  final RemoteBooksDatasource _remoteDatasource;

  @override
  Future<SearchBooksResult> searchBooks(SearchBooksParams param) async {
    final result = _remoteDatasource.searchBooksByName(param);
    return result;
  }
}
