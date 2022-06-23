// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, missing_required_param, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/news_app/cubit/cubit.dart';
import 'package:flutter_demo/modules/news_app/search/search_screen.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/cubit/cubit.dart';


import 'cubit/states.dart';
class NewsLayout extends StatelessWidget {
  const NewsLayout({Key key}) : super(key: key);
  // NewsCubit()..getBussiness()..getSports()..getScience()
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: (){
          //   },
          //   child: Icon(Icons.add),
          // ),
          appBar: AppBar(
            title: Text('NEWS APP'),
            actions: [
              IconButton(onPressed: (){navigateto(context, SearchScreen());}, icon: Icon(Icons.search)),
              IconButton(onPressed: (){AppCubit.get(context).changeAppMode();}, icon: Icon(Icons.brightness_4_outlined))
            ],
          ),
          body: cubit.Screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomitems
          ),
        );
      },
    );
  }
}