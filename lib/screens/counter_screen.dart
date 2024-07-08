import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_bloc/bloc/counter_bloc/counterBloc.dart';
import 'package:practice_bloc/bloc/counter_bloc/counterState.dart';
import 'package:practice_bloc/bloc/counter_bloc/counterEvents.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bloc Counter'),
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          if (state is CounterUpdated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Counter Value:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '${state.counterValue}',
                    style: const TextStyle(fontSize: 50),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () => context.read<CounterBloc>().add(IncrementCounter()),
                        child: const Icon(Icons.add),
                      ),
                     const  SizedBox(width: 20),
                      FloatingActionButton(
                        onPressed: () => context.read<CounterBloc>().add(DecrementCounter()),
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Counter Value:',
                    style: TextStyle(fontSize: 20),
                  ),
                   Text(
                    '${(state as CounterInitial).counterValue}',
                    style: const TextStyle(fontSize: 50),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () => context.read<CounterBloc>().add(IncrementCounter()),
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(width: 20),
                      FloatingActionButton(
                        onPressed: () => context.read<CounterBloc>().add(DecrementCounter()),
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}