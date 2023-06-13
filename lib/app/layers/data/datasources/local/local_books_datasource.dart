import 'package:my_books/app/layers/domain/entities/favorite_books.dart';

abstract class LocalBooksDatasource {
  Future<void> saveBooksToFavorites(FavoriteBooks params);
  Future<FavoriteBooks> getFavoriteBooks();
}
