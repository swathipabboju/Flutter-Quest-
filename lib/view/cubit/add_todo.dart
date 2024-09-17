import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/cubit/todolist_cubit.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD TODO"),
      ),
      body: Column(
        children: [
          TextField(
            controller: todoController,
          ),
          ElevatedButton(
              onPressed: () {
                /*  final provider = BlocProvider.of<TodolistCubit>(context);
                provider.addTodo(todoController.text.trim()); */
                // short way
                context
                    .read<TodolistCubit>()
                    .addTodo(todoController.text.trim());
                Navigator.pop(context);
              },
              child: Text("ADD"))
        ],
      ),
    );
  }
}
