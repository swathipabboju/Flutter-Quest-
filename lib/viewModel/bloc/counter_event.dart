
// to use this class in counter event class
part of 'counter_bloc_view_model.dart';

sealed class CounterEvent {}

class CounterIncrementEvent extends CounterEvent{}

class ConterDecrementedEvent extends CounterEvent{}
