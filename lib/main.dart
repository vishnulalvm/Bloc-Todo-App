import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/domine/repository.dart';
import 'package:myapp/presentation/screens/todo_home.dart';
import 'package:myapp/presentation/todo_bloc/delete_bloc/bloc/delete_bloc.dart';
import 'package:myapp/presentation/todo_bloc/edit_bloc/bloc/edit_bloc.dart';
import 'package:myapp/presentation/todo_bloc/fetch_bloc/bloc/fetch_bloc.dart';
import 'package:myapp/presentation/todo_bloc/post_bloc/bloc/post_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FetchBlocBloc(HomeRepository())),
          BlocProvider(
            create: (context) => PostBlocBloc(HomeRepository()),
          ),
          BlocProvider(
            create: (context) => DeleteBloc(HomeRepository()),
          ),
          BlocProvider(
            create: (context) => EditBloc(HomeRepository()),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: HomeScreens()));
  }
}

