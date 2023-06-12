// -----------------------------------------------------------------------------
// Global ServiceLocator
// -----------------------------------------------------------------------------
import 'package:get_it/get_it.dart';
import 'package:my_books/app/layers/data/datasources/remote/remote_books_datasource.dart';
import 'package:my_books/app/layers/data/datasources/remote/remote_books_datasource_impl.dart';
import 'package:my_books/app/layers/data/repositories/books_repository_impl.dart';
import 'package:my_books/app/layers/domain/repositories/books_repository.dart';
import 'package:my_books/app/layers/domain/usecases/search_books.dart';
import 'package:my_books/app/layers/presentation/home/cubit/home_cubit.dart';

part './layers/data_layer_injector.dart';
part './layers/domain_layer_injector.dart';
part './layers/presentation_layer_injector.dart';
part 'others/others_injector.dart';

/// We're allowing Reassignment so that when running tests we can override the
/// Factories with Mocked object versions.
///
/// Want to know how to use it? check https://pub.dev/packages/get_it
GetIt getIt = GetIt.instance..allowReassignment = true;

extension GetItExtension on GetIt {
  void init() {
    // Config the Layers
    _initializePresentationLayer();
    _initializeDomainLayer();
    _initializeDataLayer();

    // Config general classes
    _initializeOthers();
  }
}
