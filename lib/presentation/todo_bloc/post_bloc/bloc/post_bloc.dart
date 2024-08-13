import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/domine/repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBlocBloc extends Bloc<PostBlocEvent, PostBlocState> {
  HomeRepository rep;
  PostBlocBloc(this.rep) : super(PostBlocInitial()) {
    on<TodoPostEvent>((event, emit) async {
      emit(PostBlocLoading());
      try {
        await rep.postApi(event.title, event.description,);
        emit(PostBlocSuccess());
      } catch (e) {
        emit(PostBlocFailure(error: e.toString()));
      }
    });
  }
}