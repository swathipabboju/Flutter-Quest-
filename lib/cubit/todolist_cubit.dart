
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/model/cubit/todo_model.dart';

class TodolistCubit extends Cubit<List<TodoModel>> {
  TodolistCubit() : super([]);
  addTodo(String label) {
    final todo = TodoModel(name: label, createdAt: DateTime.now().toString());
    // state.add(todo);
    debugPrint("state list ${state.length}");
// with the below statement state does not notify bc current state and emitting state is same:
// emit(state);
// so we need to create another list instance
    // emit([...state]);
    // or we also create like
    emit([
      ...state,
      todo
    ]); // which means we are creating a list and adding new todo without using the state.add(todo) statement
  }

  @override
  void onChange(Change<List<TodoModel>> change) {
    super.onChange(change);
    debugPrint("state list $change}");
  }
}
