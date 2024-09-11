import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  // CounterCubit(super.initialState);
  increment() {
    emit(state + 1);
  }

  decrement() {
    // standard
    if (state == 0) {
      return;
    }
    emit(state - 1);

    // simpler way
    /* if (state > 0) {
      emit(state - 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("state can not be negative")));
    } */
  }

  reset() {
    emit(state - state);
  }
}

/* import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
} */