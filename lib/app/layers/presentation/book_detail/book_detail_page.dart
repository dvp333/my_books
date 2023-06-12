import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_books/app/layers/domain/entities/search_books_result.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  static const routeName = '/books/detail';

  final Item book;

  static Route<bool> route({required Item book}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BookDetailPage(book: book),
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
              Hero(
                tag: book.volumeInfo!.title!,
                child: _buildBookImage(book),
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
                book.volumeInfo?.description ?? '-',
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
    return ElevatedButton(
        onPressed: () {
          _launchUrl(book.saleInfo!.buyLink, context);
        },
        child: Text('Comprar '
            '${saleInfo.retailPrice!.amount} ${saleInfo.retailPrice!.currencyCode!}'));
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

  _buildBookImage(Item book) {
    if (book.volumeInfo?.imageLinks == null) return const Icon(Icons.book);
    return CachedNetworkImage(
      imageUrl: book.volumeInfo!.imageLinks!.thumbnail!,
      placeholder: (context, url) => const Icon(Icons.book),
      errorWidget: (context, url, error) => const Icon(Icons.book),
    );
  }
}
