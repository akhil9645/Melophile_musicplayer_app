import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'for_nav_event.dart';
part 'for_nav_state.dart';

class ForNavBloc extends Bloc<ForNavEvent, ForNavState> {
  ForNavBloc() : super(ForNavInitial()) {
    on<ForNavEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
