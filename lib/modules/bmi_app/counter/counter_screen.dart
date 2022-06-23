// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/modules/bmi_app/counter/cubit/cubit.dart';
import 'package:flutter_demo/modules/bmi_app/counter/cubit/state.dart';

class CounterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context,state){
          if(state is CounterPlusState){
            print('plus state ${state.counter}');
          }
          if(state is CounterMinState){
            print('MIN state ${state.counter}');
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter Screen'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: (){
                        CounterCubit.get(context).minus();
                      },
                      child: Text('MINUS',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700),)
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('${CounterCubit.get(context).counter}',style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.w700),),
                  ),
                  TextButton(
                      onPressed: (){
                        CounterCubit.get(context).plus();
                      },
                      child: Text('PLUS',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700),)
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
