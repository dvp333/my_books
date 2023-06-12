import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_books/app/layers/data/datasources/remote/remote_books_datasource.dart';
import 'package:my_books/app/layers/domain/entities/search_books_result.dart';
import 'package:my_books/app/layers/domain/usecases/search_books.dart';

class RemoteBooksDatasourceImpl implements RemoteBooksDatasource {
  static const booksApiUrl =
      'https://www.googleapis.com/books/v1/volumes?printType=books&fields=totalItems,items(volumeInfo/title,volumeInfo/description,saleInfo/retailPrice,saleInfo/buyLink,volumeInfo/imageLinks)';

  @override
  Future<SearchBooksResult> searchBooksByName(SearchBooksParams params) async {
    final httpResponse = await http.get(
      Uri.parse(
          '$booksApiUrl&q=${params.searchtext}&maxResults=${SearchBooksParams.maxResults}&startIndex=${params.currentPaginationIndex}'),
    );
    if (httpResponse.statusCode == 200) {
      final searchBooksResponse =
          SearchBooksResult.fromJson(jsonDecode(httpResponse.body));
      return searchBooksResponse;
    } else {
      throw Exception('Erro ao pesquisar livros.');
    }
  }
}
