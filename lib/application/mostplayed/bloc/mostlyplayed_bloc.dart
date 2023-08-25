import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mostlyplayed_event.dart';
part 'mostlyplayed_state.dart';

class MostlyplayedBloc extends Bloc<MostlyplayedEvent, MostlyplayedState> {
  MostlyplayedBloc() : super(MostlyplayedInitial()) {
    on<MostlyplayedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
