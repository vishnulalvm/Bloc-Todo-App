import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/domine/repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBlocBloc extends Bloc<PostBlocEvent, PostBlocState> {
  HomeRepository rep;
  PostBlocBloc(this.rep) : super(PostBlocInitial()) {
    on<TodoPostEvent>((event, emit) async{
      rep.postApi(event.title, event.description);
    });
  }
}