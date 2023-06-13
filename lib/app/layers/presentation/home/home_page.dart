import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/app/layers/domain/entities/book.dart';
import 'package:my_books/app/layers/domain/entities/sale_info.dart';
import 'package:my_books/app/layers/presentation/book_detail/book_detail_page.dart';
import 'package:my_books/app/layers/presentation/favorites/favorites_page.dart';
import 'package:my_books/app/layers/presentation/home/cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _textController;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.addListener(() {
      context.read<HomeCubit>().searchBook(_textController.text);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        context.read<HomeCubit>().loadMoreBooks();
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(FavoritesPage.route());
              },
              icon: const Icon(Icons.favorite)),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15.0),
              Material(
                elevation: 6.0,
                borderRadius: BorderRadius.circular(30),
                child: TextField(
                  controller: _textController,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(width: 4)),
                    hintText: 'Digite o nome de um livro...',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 18),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(15),
                      width: 18,
                      child: const Icon(Icons.search),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => _textController.clear(),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state.errorMessage?.isNotEmpty ?? false) {
                    _showErrorMessage(state.errorMessage!);
                  }
                },
                builder: (context, state) {
                  return state.isLoading
                      ? const SizedBox(
                          height: 40.0,
                          width: 40.0,
                          child: CircularProgressIndicator())
                      : Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: state.books.isNotEmpty
                                ? state.books.length + 1
                                : 0,
                            itemBuilder: (context, index) {
                              return index < state.books.length
                                  ? Card(
                                      elevation: 8,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            BookDetailPage.route(
                                                book: state.books[index]),
                                          );
                                        },
                                        child: ListTile(
                                          leading:
                                              _getBookImage(state.books[index]),
                                          title: Text(state.books[index]
                                                  .volumeInfo?.title ??
                                              'Sem título'),
                                          subtitle: Text(_getPrice(
                                              state.books[index].saleInfo)),
                                          trailing: const IconButton(
                                            onPressed: null,
                                            icon: Icon(Icons.arrow_forward),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                            },
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorMessage(String msg) {
    final snackBar = SnackBar(
        content: Text(
      msg,
      style: const TextStyle(color: Colors.red),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
}
