part of 'post_bloc.dart';

sealed class PostBlocEvent extends Equatable{
  const PostBlocEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class TodoPostEvent extends PostBlocEvent{
  String title;
  String description;
  TodoPostEvent({required this.title, required this.description});
  @override
  List<Object> get props => [title, description];
}