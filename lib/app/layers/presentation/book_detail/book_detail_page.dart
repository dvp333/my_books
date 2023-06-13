import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/app/injection/injector.dart';
import 'package:my_books/app/layers/domain/entities/book.dart';
import 'package:my_books/app/layers/domain/entities/sale_info.dart';
import 'package:my_books/app/layers/presentation/book_detail/cubit/book_detail_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  static const routeName = '/books/detail';

  final Book book;

  static Route<bool> route({required Book book}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        final cubit = getIt<BookDetailCubit>();
        WidgetsBinding.instance
            .addPostFrameCallback((timeStamp) => cubit.init(book));
        return BlocProvider(
          create: (context) => cubit,
          child: BookDetailPage(book: book),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.volumeInfo!.title!)),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Hero(
                      tag: book.volumeInfo!.title!,
                      child: _buildBookImage(book),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: BlocBuilder<BookDetailCubit, BookDetailState>(
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () {
                              context
                                  .read<BookDetailCubit>()
                                  .changeFavoriteState(book);
                            },
                            icon: Icon(
                              state.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sinopse',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                book.volumeInfo?.description ?? 'Sinopse não disponível',
                textAlign: TextAlign.justify,
                style: const TextStyle(),
              ),
              const SizedBox(height: 15),
              _buildSellArea(book.saleInfo, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSellArea(SaleInfo? saleInfo, BuildContext context) {
    if (saleInfo == null) return const SizedBox();

    var price = '';

    if (saleInfo.retailPrice != null) {
      price =
          ' ${saleInfo.retailPrice!.amount} ${saleInfo.retailPrice!.currencyCode!}';
    }

    return ElevatedButton(
        onPressed: () {
          _launchUrl(book.saleInfo!.buyLink, context);
        },
        child: Text('Comprar$price'));
  }

  void _launchUrl(url, BuildContext context) {
    launchUrl(Uri.parse(url)).then((isOk) {
      if (!isOk) {
        _showErrorMessage('Erro ao tentar abrir link de compra.', context);
      }
    });
  }

  void _showErrorMessage(String msg, BuildContext context) {
    final snackBar = SnackBar(
        content: Text(
      msg,
      style: const TextStyle(color: Colors.red),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _buildBookImage(Book book) {
    if (book.volumeInfo?.imageLinks == null) return const Icon(Icons.book);
    return CachedNetworkImage(
      imageUrl: book.volumeInfo!.imageLinks!.thumbnail!,
      placeholder: (context, url) => const Icon(Icons.book),
      errorWidget: (context, url, error) => const Icon(Icons.book),
    );
  }
}
