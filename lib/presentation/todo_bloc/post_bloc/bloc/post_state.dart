part of 'post_bloc.dart';

sealed class PostBlocState extends Equatable{
const PostBlocState();

@override
List<Object> get props => [];
}

final class PostBlocInitial extends PostBlocState {}
