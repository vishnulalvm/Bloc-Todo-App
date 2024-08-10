// ignore_for_file: must_be_immutable, prefer_const_constructors, sort_child_properties_last
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:myapp/colors.dart';
import 'package:myapp/domine/model.dart';
import 'package:myapp/domine/repository.dart';
import 'package:myapp/presentation/screens/add_screen.dart';
import 'package:myapp/presentation/todo_bloc/delete_bloc/bloc/delete_bloc.dart';
import 'package:myapp/presentation/todo_bloc/fetch_bloc/bloc/fetch_bloc.dart';

class HomeScreens extends StatelessWidget {
  HomeScreens({super.key});
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchBlocBloc(HomeRepository())..add(TodoLoadedEvent()),
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 30,
                      color: CustomColor.getColor(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  text[Random().nextInt(text.length)],
                  style: TextStyle(
                      fontSize: 16,
                      color: Random().nextInt(text.length) > 9
                          ? CustomColor.getColor()
                          : Color.fromARGB(255, 175, 255, 4)),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<FetchBlocBloc>().add(TodoLoadedEvent());
                  },
                  child: Visibility(
                    visible: isLoading,
                    child: Center(child: Text("Nothing to show")),
                    replacement: BlocBuilder<FetchBlocBloc, FetchBlocState>(
                      builder: (context, state) {
                        if (state is TodoLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is TodoLoadedState) {
                          List<TodoModel> list = state.todolist;

                          return ListView.builder(
                            padding: const EdgeInsets.only(top: 30),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              // final note = list[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 20),
                                color: backgroundColors[
                                    Random().nextInt(backgroundColors.length)],
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: ListTile(
                                    onTap: () {
                                      navigateToEdit(
                                          context,
                                          list[index].sId.toString(),
                                          list[index]);
                                    },
                                    title: RichText(
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: '${list[index].title} \n',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          height: 2,
                                        ),
                                        
                                        children: [
                                          TextSpan(
                                            text: '${list[index].description}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: Text(""),
                                    trailing: IconButton(
                                      onPressed: () {
                                        context.read<DeleteBloc>().add(
                                            TodoDeleteEvent(
                                                id: list[index]
                                                    .sId
                                                    .toString()));
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreens(),
                                          ),
                                          (route) => false,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                    
                                  ),
                                  
                                ),
                                
                              );
                            },
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColor.getColor(),
          onPressed: () {
            navigateToAdd(
              context,
            );
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }

  Future<void> navigateToAdd(context) async {
    final route = MaterialPageRoute(
      builder: (context) => AddPage(
        isEdit: false,
      ),
    );
    await Navigator.push(context, route);
  }

  Future<void> navigateToEdit(context, String id, TodoModel mode) async {
    final route = MaterialPageRoute(
      builder: (context) => AddPage(id: id, model: mode, isEdit: true),
    );
    await Navigator.push(context, route);
  }
}
