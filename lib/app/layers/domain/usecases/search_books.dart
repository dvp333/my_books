import 'package:dartz/dartz.dart';
import 'package:my_books/app/layers/domain/entities/search_books_result.dart';
import 'package:my_books/app/layers/domain/repositories/books_repository.dart';
import 'package:my_books/app/layers/domain/usecases/base/failure.dart';
import 'package:my_books/app/layers/domain/usecases/base/usecase.dart';

class SearchBooks extends UseCase<SearchBooksResult, SearchBooksParams> {
  final BooksRepository _repository;

  SearchBooks({
    required BooksRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, SearchBooksResult>> run([SearchBooksParams? p]) async {
    final result = await _repository.searchBooks(p!);
    return right(result);
  }
}

class SearchBooksParams {
  final String searchtext;
  final int currentPaginationIndex;
  static const int maxResults = 20;

  const SearchBooksParams({
    required this.searchtext,
    required this.currentPaginationIndex,
  });
}
