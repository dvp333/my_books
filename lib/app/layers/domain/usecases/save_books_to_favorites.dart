import 'package:dartz/dartz.dart';
import 'package:my_books/app/layers/domain/entities/favorite_books.dart';
import 'package:my_books/app/layers/domain/repositories/books_repository.dart';
import 'package:my_books/app/layers/domain/usecases/base/failure.dart';
import 'package:my_books/app/layers/domain/usecases/base/usecase.dart';

class SaveBooksToFavorites extends UseCase<void, FavoriteBooks> {
  SaveBooksToFavorites({required BooksRepository repository})
      : _repository = repository;

  final BooksRepository _repository;

  @override
  Future<Either<Failure, void>> run([FavoriteBooks? p]) async {
    _repository.saveBooksTofavoriteLocally(p!);
    return right(null);
  }
}
