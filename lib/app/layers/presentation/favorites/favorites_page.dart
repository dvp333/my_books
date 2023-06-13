import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/app/injection/injector.dart';
import 'package:my_books/app/layers/domain/entities/book.dart';
import 'package:my_books/app/layers/domain/entities/sale_info.dart';
import 'package:my_books/app/layers/presentation/book_detail/book_detail_page.dart';
import 'package:my_books/app/layers/presentation/favorites/cubit/favorites_cubit.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  static const routeName = '/books/favorites';

  static Route<bool> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        final cubit = getIt<FavoritesCubit>();
        WidgetsBinding.instance
            .addPostFrameCallback((timeStamp) => cubit.init());
        return BlocProvider(
          create: (context) => cubit,
          child: const FavoritesPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Favorite Books',
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(FavoritesPage.route());
              },
              icon: const Icon(Icons.favorite)),
        ],
      ),
      body: BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (context, state) {
          if (state.errorMsg?.isNotEmpty ?? false) {
            _showErrorMessage(state.errorMsg!, context);
          }
        },
        builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 8,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      BookDetailPage.route(book: state.books[index]),
                    );
                  },
                  child: ListTile(
                    leading: _getBookImage(state.books[index]),
                    title: Text(
                        state.books[index].volumeInfo?.title ?? 'Sem título'),
                    subtitle: Text(_getPrice(state.books[index].saleInfo)),
                    trailing: const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _getPrice(SaleInfo? saleInfo) {
    if (saleInfo?.retailPrice == null) {
      return '-';
    } else {
      return '${saleInfo?.retailPrice?.amount} ${saleInfo?.retailPrice?.currencyCode}';
    }
  }

  Widget _getBookImage(Book book) {
    if (book.volumeInfo!.imageLinks == null) {
      return const Icon(Icons.book);
    }

    return Hero(
      tag: book.volumeInfo!.title!,
      child: CachedNetworkImage(
        imageUrl: book.volumeInfo!.imageLinks!.thumbnail!,
        placeholder: (context, url) => const Icon(Icons.book),
        errorWidget: (context, url, error) => const Icon(Icons.book),
      ),
    );
  }

  void _showErrorMessage(String msg, BuildContext context) {
    final snackBar = SnackBar(
        content: Text(
      msg,
      style: const TextStyle(color: Colors.red),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
