// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/shop_app/cubit/states.dart';
import 'package:flutter_demo/modules/shop_app/search/search_screen.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('MR-SHOPPY'),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateto(context, SearchShopScreen());
                  },
                  icon:Icon( Icons.search))
            ],
          ),
          body:cubit.bottomScreens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index){cubit.changeBottom(index);},
            currentIndex: cubit.currentindex,
            items: [
              BottomNavigationBarItem(
                  icon:Icon(Icons.home),
                  label: 'HOME'
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.shop_outlined),
                  label: 'CATEGORIES'
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.favorite_border),
                  label: 'FAVORITES'
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.settings),
                  label: 'SETTING'
              ),
            ],
          ),
          // TextButton(
          //   onPressed: (){
          //     SignOut(context);
          //
          //   },
          //   child: Text('SIGN OUT'),
          // ),

        );
      },

    );
  }
}
