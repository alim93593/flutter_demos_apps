// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/cubit/cubit.dart';
import 'package:flutter_demo/shared/cubit/states.dart';

class ArichivedTasksScreen extends StatelessWidget {
  const ArichivedTasksScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).archivetasks;
          return taskBuilder(tasks:tasks);
        });
  }
}
