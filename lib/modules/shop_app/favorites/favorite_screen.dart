// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, unrelated_type_equality_checks, sized_box_for_whitespace, non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps, prefer_is_empty

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/shop_app/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';

class  FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoritesState){
          if(state.model.status) {
            showtoast(text: state.model.message, state: ToastStates.SUCCESS);
          }
        }
      },
      builder:(context,state){
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is !ShopLoadinGetFavoritesState,
          builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>BuildListProducts(cubit.getFavoriteModel.data.data[index].product,context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: cubit.getFavoriteModel.data.data.length
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      } ,
    );
  }

}
