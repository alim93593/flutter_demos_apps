// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/news_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/news_app/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: ( context, state){},
      builder: ( context, state) {
        var list = NewsCubit.get(context).bussiness;
        return articlebuilder(list,itemcount: list.length);
      },
    );
  }
}
