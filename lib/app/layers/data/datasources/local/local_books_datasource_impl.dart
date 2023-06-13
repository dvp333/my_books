import 'dart:convert';

import 'package:my_books/app/layers/data/datasources/local/local_books_datasource.dart';
import 'package:my_books/app/layers/domain/entities/favorite_books.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalBooksDatasourceImpl implements LocalBooksDatasource {
  final SharedPreferences _preferences;

  LocalBooksDatasourceImpl({required SharedPreferences preferences})
      : _preferences = preferences;

  static const favoriteBooksKey = 'favoriteBooksKey';

  @override
  Future<void> saveBooksToFavorites(FavoriteBooks params) async {
    await _preferences.setString(favoriteBooksKey, jsonEncode(params.toJson()));
  }

  @override
  Future<FavoriteBooks> getFavoriteBooks() async {
    final booksJson = _preferences.getString(favoriteBooksKey);
    if (booksJson == null) return FavoriteBooks.empty();
    return FavoriteBooks.fromJson(jsonDecode(booksJson));
  }
}
