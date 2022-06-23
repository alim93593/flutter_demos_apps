// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/news_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/news_app/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: ( context, state){},
      builder: ( context, state) {
        var list = NewsCubit.get(context).sports;
        return articlebuilder(list,itemcount: list.length);
      },
    );
  }
}
