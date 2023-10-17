import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'replay_event.dart';
part 'replay_state.dart';

class ReplayBloc extends Bloc<ReplayEvent, ReplayState> {
  ReplayBloc() : super(ReplayInitial()) {
    on<ReplayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
