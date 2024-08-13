import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/domine/model.dart';
import 'package:myapp/domine/repository.dart';

part 'fetch_event.dart';
part 'fetch_state.dart';

class FetchBlocBloc extends Bloc<FetchBlocEvent, FetchBlocState> {
  HomeRepository rep;
  FetchBlocBloc(this.rep) : super(FetchBlocInitial()) {
    on<FetchBlocEvent>((event, emit) async {
     emit(TodoLoadingState());

     try{
      final todo = await rep.fetchApi();
      emit(TodoLoadedState( todolist: todo));
     }catch(e) {
      emit(TodoErrorState(error: e.toString()));
     }
    });
  }
}
