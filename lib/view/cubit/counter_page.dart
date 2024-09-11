import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/utils/Routes/appRoutes.dart';
import 'package:sample_app/viewModel/cubit/counter_cubit_view_model.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  // final counterInstance = CounterCubit();
  @override
  Widget build(BuildContext context) {
    // like provide instance
    final counterCubit = BlocProvider.of<CounterCubit>(context);
    // final counterCubit = CounterCubit();
    return Scaffold(
      appBar: AppBar(
        title: Text("counter"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    counterCubit.increment();
                  },
                  child: Text("+")),
              BlocBuilder<CounterCubit, int>(
                bloc: counterCubit,
                builder: (BuildContext context, state) {
                  return Text("${counterCubit.state}");
                },
              ),
              TextButton(
                  onPressed: () {
                    counterCubit.decrement();
                  },
                  child: Text("-"))
            ],
          ),
          TextButton(
              onPressed: () {
                counterCubit.reset();
              },
              child: Text("reset")),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.counterBlocPage);
              },
              child: Text("next"))
        ],
      ),
    );
  }
}

/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/viewModel/bloc/counter_cubit_view_model.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, count) => Center(child: Text('$count')),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}
 */