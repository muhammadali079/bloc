abstract class CounterState {}

class CounterInitial extends CounterState {
  final int counterValue;

  CounterInitial(this.counterValue);
}

class CounterUpdated extends CounterState {
  final int counterValue;

  CounterUpdated(this.counterValue);
}