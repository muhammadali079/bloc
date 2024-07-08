import 'package:flutter_bloc/flutter_bloc.dart';
import 'counterState.dart';
import 'counterEvents.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial(0)) {
    on<IncrementCounter>((event, emit) {
      if (state is CounterInitial) {
        int updatedCount = (state as CounterInitial).counterValue + 1;
        emit(CounterUpdated(updatedCount));
      } else if (state is CounterUpdated) {
        int updatedCount = (state as CounterUpdated).counterValue + 1;
        emit(CounterUpdated(updatedCount));
      }
    });

    on<DecrementCounter>((event, emit) {
      if (state is CounterInitial) {
        int updatedCount = (state as CounterInitial).counterValue - 1;
        if (updatedCount<0){
          updatedCount=0;
        }
        emit(CounterUpdated(updatedCount));
      } else if (state is CounterUpdated) {
        int updatedCount = (state as CounterUpdated).counterValue - 1;
        if (updatedCount<0){
          updatedCount=0;
        }
        emit(CounterUpdated(updatedCount));
      }
    });
  }
}
