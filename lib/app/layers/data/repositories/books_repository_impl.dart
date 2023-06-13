import 'package:my_books/app/layers/data/datasources/local/local_books_datasource.dart';
import 'package:my_books/app/layers/data/datasources/remote/remote_books_datasource.dart';
import 'package:my_books/app/layers/domain/entities/favorite_books.dart';
import 'package:my_books/app/layers/domain/entities/search_books_result.dart';
import 'package:my_books/app/layers/domain/repositories/books_repository.dart';
import 'package:my_books/app/layers/domain/usecases/search_books.dart';

class BooksRepositoryImpl implements BooksRepository {
  BooksRepositoryImpl({
    required RemoteBooksDatasource remoteDatasource,
    required LocalBooksDatasource localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  final RemoteBooksDatasource _remoteDatasource;
  final LocalBooksDatasource _localDatasource;

  @override
  Future<SearchBooksResult> searchBooks(SearchBooksParams param) async {
    final result = _remoteDatasource.searchBooksByName(param);
    return result;
  }

  @override
  Future<void> saveBooksTofavoriteLocally(FavoriteBooks books) async {
    _localDatasource.saveBooksToFavorites(books);
  }

  @override
  Future<FavoriteBooks> getFavoriteBooksLocally() {
    return _localDatasource.getFavoriteBooks();
  }
}
