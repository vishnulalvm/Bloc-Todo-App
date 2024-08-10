// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/colors.dart';
import 'package:myapp/domine/model.dart';
import 'package:myapp/presentation/screens/todo_home.dart';
import 'package:myapp/presentation/todo_bloc/edit_bloc/bloc/edit_bloc.dart';
import 'package:myapp/presentation/todo_bloc/post_bloc/bloc/post_bloc.dart';

class AddPage extends StatelessWidget {
  final Map? todo;
  AddPage({super.key, this.todo, this.id, this.model, required this.isEdit});
  String? id;
  bool isEdit;
  TodoModel? model;
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isEdit) {
      titleController.text = model!.title!;
      descriptionController.text = model!.description!;
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          isEdit ? 'Edit ToDo' : 'Add ToDo',
          style: TextStyle(color: CustomColor.getColor()),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            style: TextStyle(color: CustomColor.getColor()),
            controller: titleController,
            decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: CustomColor.getColor())),
          ),
          TextField(
            style: TextStyle(color: CustomColor.getColor()),
            controller: descriptionController,
            decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: CustomColor.getColor())),
            keyboardType: TextInputType.multiline,
            maxLines: 8,
            minLines: 5,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: const Color.fromARGB(255, 242, 45, 45),
        onPressed: () {
          isEdit ? update(context) : submit(context);
        },
        elevation: 10,
        backgroundColor: CustomColor.getColor(),
        child: const Icon(Icons.save),
      ),
    );
  }

  void submit(BuildContext context) {
    BlocProvider.of<PostBlocBloc>(context).add(TodoPostEvent(
        title: titleController.text, description: descriptionController.text));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreens(),
      ),
      (route) => false,
    );
  }

  void update(BuildContext context) {
    BlocProvider.of<EditBloc>(context).add(TodoEditEvent(
        id: id ?? '1',
        title: titleController.text,
        description: descriptionController.text));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreens(),
      ),
      (route) => false,
    );
  }
}
