part of 'fetch_bloc.dart';


sealed class FetchBlocState {}

final class FetchBlocInitial extends FetchBlocState {}

class TodoLoadingState extends FetchBlocState {

List<Object?> get props =>[];
}

class TodoLoadedState extends FetchBlocState {
  List<TodoModel> todolist = [];
TodoLoadedState({required this.todolist});

List<Object> get props => [todolist];
}

class TodoErrorState extends FetchBlocState {
  String? error;
  TodoErrorState({this.error});

  List<Object?> get props => [error];
}
