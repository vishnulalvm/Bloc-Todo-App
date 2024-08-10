part of 'delete_bloc.dart';


sealed class DeleteEvent extends Equatable{
  const DeleteEvent();

  @override 
  List<Object> get props => [];
}

class TodoDeleteEvent extends DeleteEvent{
  final String id;
  const TodoDeleteEvent({required this.id});

  @override 
  List<Object> get props => [id];
}