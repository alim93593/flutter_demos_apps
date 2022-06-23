// ignore_for_file: unnecessary_import, unnecessary_this

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/modules/bmi_app/counter/cubit/state.dart';




class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(CounterIntialState());
  static CounterCubit get(context)=>BlocProvider.of(context);

  int counter = 0;
  void minus(){
    counter--;
    emit(CounterMinState(this.counter));
  }
  void plus(){
    counter++;
    emit(CounterPlusState(this.counter));
  }

}