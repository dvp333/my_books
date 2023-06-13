import 'package:dartz/dartz.dart';
import 'package:my_books/app/layers/domain/entities/favorite_books.dart';
import 'package:my_books/app/layers/domain/repositories/books_repository.dart';
import 'package:my_books/app/layers/domain/usecases/base/failure.dart';
import 'package:my_books/app/layers/domain/usecases/base/usecase.dart';

class GetFavoriteBooks extends UseCase<FavoriteBooks, NoParams> {
  GetFavoriteBooks({required BooksRepository repository})
      : _repository = repository;

  final BooksRepository _repository;

  @override
  Future<Either<Failure, FavoriteBooks>> run([NoParams? p]) async {
    final books = await _repository.getFavoriteBooksLocally();
    return right(books);
  }
}
