import 'package:flutter_bloc/flutter_bloc.dart';

// instead of import we can use this
part 'counter_event.dart';

// this is bloc
// bloc needs event and state both
class CounterBlocViewModel extends Bloc<CounterEvent, int> {
  // CounterBlocViewModel() : super(0);
  CounterBlocViewModel() : super(0) {
    on<CounterIncrementEvent>(
      (event, emit) {
        // emit can only be used in this function not oin any other function
        emit(state + 1);
      },
    );
    on<ConterDecrementedEvent>(
      (event, emit) {
        if (state == 0) {
          return;
        }
        emit(state - 1);
      },
    );
  }
}
