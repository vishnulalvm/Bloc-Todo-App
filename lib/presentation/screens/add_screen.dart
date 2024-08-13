import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/colors.dart';
import 'package:myapp/domine/model.dart';
import 'package:myapp/presentation/screens/todo_home.dart';
import 'package:myapp/presentation/todo_bloc/edit_bloc/bloc/edit_bloc.dart';
import 'package:myapp/presentation/todo_bloc/post_bloc/bloc/post_bloc.dart';

// ignore: must_be_immutable
class AddPage extends StatelessWidget {
  final Map? todo;
  String? id;
  bool isEdit;
  TodoModel? model;
  AddPage({super.key, this.todo, this.id, this.model, required this.isEdit});

  final _formKey = GlobalKey<FormState>();
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
        iconTheme: IconThemeData(color: CustomColor.getColor()),
        backgroundColor: Colors.grey.shade900,
        title: Text(
          isEdit ? 'Edit ToDo' : 'Add Todo',
          style: TextStyle(color: CustomColor.getColor()),
        ),
      ),
      body: BlocListener<PostBlocBloc, PostBlocState>(
        listener: (context, state) {
          if (state is PostBlocSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Todo added successfully!')),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreens()),
              (route) => false,
            );
          } else if (state is PostBlocFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Failed to add todo. Please try again.')),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                style: TextStyle(color: CustomColor.getColor()),
                controller: titleController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Title',
                  hintStyle: TextStyle(color: CustomColor.getColor()),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: CustomColor.getColor()),
                controller: descriptionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Description',
                  hintStyle: TextStyle(color: CustomColor.getColor()),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                minLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: const Color.fromARGB(255, 242, 45, 45),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            isEdit ? update(context) : submit(context);
          }
        },
        elevation: 10,
        backgroundColor: CustomColor.getColor(),
        child: const Icon(Icons.save),
      ),
    );
  }

  void submit(BuildContext context) {
    BlocProvider.of<PostBlocBloc>(context).add(TodoPostEvent(
      title: titleController.text,
      description: descriptionController.text,
    ));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreens()),
      (route) => false,
    );
  }

  void update(BuildContext context) {
    BlocProvider.of<EditBloc>(context).add(TodoEditEvent(
      id: id ?? '1',
      title: titleController.text,
      description: descriptionController.text,
    ));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreens()),
      (route) => false,
    );
  }
}
