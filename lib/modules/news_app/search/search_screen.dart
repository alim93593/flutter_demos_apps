// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/news_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/news_app/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';

class SearchScreen extends StatelessWidget {

  var searchcontroller = TextEditingController();

  SearchScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  color: Colors.white,
                  child: defaultFormFeild(
                      controller: searchcontroller,
                      type: TextInputType.text,
                      onchanged: (value){
                        NewsCubit.get(context).getSearch(value);
                      },
                      validate: (String value){
                        if(value.trim().isEmpty){
                          return 'Search Must not be empty';
                        }
                        return null;
                      },
                      label: 'Search',
                      prefix: Icons.search),
                ),
              ),
              Expanded(child: articlebuilder(list, itemcount: list.length,issearch: true)),
            ],
          ),
        );
      },
    );

  }
}
