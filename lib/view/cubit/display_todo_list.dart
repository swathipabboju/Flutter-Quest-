import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/cubit/todolist_cubit.dart';
import 'package:sample_app/model/cubit/todo_model.dart';
import 'package:sample_app/utils/Routes/appRoutes.dart';

class DisplayTodoList extends StatefulWidget {
  const DisplayTodoList({super.key});

  @override
  State<DisplayTodoList> createState() => _DisplayTodoListState();
}

class _DisplayTodoListState extends State<DisplayTodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo list"),
      ),
      body: BlocBuilder<TodolistCubit, List<TodoModel>>(
        // builder: (context, state) {
        // state renamed to todos for our convience
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${todos[index].name}"),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addtodo);
        },
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
