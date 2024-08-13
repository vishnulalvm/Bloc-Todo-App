part of 'post_bloc.dart';

// part 'post_state.dart';

abstract class PostBlocState extends Equatable {
  const PostBlocState();
  
  @override
  List<Object> get props => [];
}

class PostBlocInitial extends PostBlocState {}

class PostBlocLoading extends PostBlocState {}

class PostBlocSuccess extends PostBlocState {}

class PostBlocFailure extends PostBlocState {
  final String error;
  
  const PostBlocFailure({required this.error});
  
  @override
  List<Object> get props => [error];
}
