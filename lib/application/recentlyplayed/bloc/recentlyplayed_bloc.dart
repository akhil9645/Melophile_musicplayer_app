import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'recentlyplayed_event.dart';
part 'recentlyplayed_state.dart';

class RecentlyplayedBloc extends Bloc<RecentlyplayedEvent, RecentlyplayedState> {
  RecentlyplayedBloc() : super(RecentlyplayedInitial()) {
    on<RecentlyplayedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
