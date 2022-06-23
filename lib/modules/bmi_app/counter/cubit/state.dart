// ignore_for_file: unused_import

import 'package:bloc/bloc.dart';

abstract  class CounterStates{}
class CounterIntialState  extends CounterStates{}

class CounterPlusState  extends CounterStates{
  final int counter;
  CounterPlusState(this.counter);
}

class CounterMinState  extends CounterStates{
  final int counter;
  CounterMinState(this.counter);
}