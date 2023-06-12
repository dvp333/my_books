import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/app/injection/injector.dart';
import 'package:my_books/app/layers/presentation/home/cubit/home_cubit.dart';
import 'package:my_books/app/layers/presentation/home/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Books',
      theme: ThemeData(),
      home: BlocProvider(
        create: (context) => getIt<HomeCubit>(),
        child: const HomePage(title: 'My Books'),
      ),
    );
  }
}
