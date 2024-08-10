part of 'fetch_bloc.dart';

abstract class FetchBlocEvent extends Equatable {
 const  FetchBlocEvent();


}
class TodoLoadedEvent extends FetchBlocEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  //  @override
  // List<Object> get props => [];


}
