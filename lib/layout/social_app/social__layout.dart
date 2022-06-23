// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, missing_return

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/social_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/social_app/cubit/states.dart';
import 'package:flutter_demo/modules/social_app/new_post/new_post_screen.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialNewPostState){
          navigateto(context, NewPostScreen());
        }
      },
      builder: (context,state){
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentindex]),
            actions: [
              IconButton(
                  icon: Icon(Icons.notifications_active_outlined),
                  onPressed: (){

                  },
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){

                },
              ),
            ],
          ),
          body:cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            items: [
              BottomNavigationBarItem(icon:Icon(Icons.home_outlined),label: 'Home'),
              BottomNavigationBarItem(icon:Icon(Icons.chat_outlined),label: 'Chat'),
              BottomNavigationBarItem(icon:Icon(Icons.post_add),label: 'Post'),
              BottomNavigationBarItem(icon:Icon(Icons.location_city_outlined),label: 'Users'),
              BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'Setting'),
            ],
            onTap: (index){
              cubit.ChangeBottomnav(index);
            },
          ),
        );
      },
    );
  }
}
