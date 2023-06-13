// -----------------------------------------------------------------------------
// Global ServiceLocator
// -----------------------------------------------------------------------------
import 'package:get_it/get_it.dart';
import 'package:my_books/app/layers/data/datasources/local/local_books_datasource.dart';
import 'package:my_books/app/layers/data/datasources/local/local_books_datasource_impl.dart';
import 'package:my_books/app/layers/data/datasources/remote/remote_books_datasource.dart';
import 'package:my_books/app/layers/data/datasources/remote/remote_books_datasource_impl.dart';
import 'package:my_books/app/layers/data/repositories/books_repository_impl.dart';
import 'package:my_books/app/layers/domain/repositories/books_repository.dart';
import 'package:my_books/app/layers/domain/usecases/get_favorite_books.dart';
import 'package:my_books/app/layers/domain/usecases/save_books_to_favorites.dart';
import 'package:my_books/app/layers/domain/usecases/search_books.dart';
import 'package:my_books/app/layers/presentation/book_detail/cubit/book_detail_cubit.dart';
import 'package:my_books/app/layers/presentation/home/cubit/home_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part './layers/data_layer_injector.dart';
part './layers/domain_layer_injector.dart';
part './layers/presentation_layer_injector.dart';
part 'others/others_injector.dart';

GetIt getIt = GetIt.instance;

extension GetItExtension on GetIt {
  void init() {
    _initializeThirdParty();
    _initializePresentationLayer();
    _initializeDomainLayer();
    _initializeDataLayer();
  }
}
