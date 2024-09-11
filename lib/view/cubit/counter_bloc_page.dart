import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/viewModel/bloc/counter_bloc_view_model.dart';
import 'package:sample_app/viewModel/cubit/counter_cubit_view_model.dart';


// bloc  rely on states
// cubit   rely on  functions
class CounterBlocPage extends StatelessWidget { 
  const CounterBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterCubit = BlocProvider.of<CounterCubit>(context);
    final counterBloc = BlocProvider.of<CounterBlocViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("counter"),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                counterBloc.add(CounterIncrementEvent());
                // counterCubit.increment();
              },
              child: Text("+")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${counterCubit.state}"),
            ],
          ),
          TextButton(
              onPressed: () {
                counterCubit.reset();
              },
              child: Text("reset"))
        ],
      ),
    );
  }
}
