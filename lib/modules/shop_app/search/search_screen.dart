// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/modules/shop_app/search/cubit/cubit.dart';
import 'package:flutter_demo/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';

class  SearchShopScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();
  var searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formkey,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                    children: [
                      SizedBox(height: 30.0,),
                      defaultFormFeild(
                          controller: searchcontroller,
                          type: TextInputType.text,
                          validate: (String value){
                            if(value.isEmpty){
                              return 'Please Enter Value To Search Here';
                            }
                            return null;
                          },
                          onsubmit: (String text){
                            SearchCubit.get(context).search(text);
                          },
                          label: 'Search Here',
                          prefix: Icons.search
                      ),
                      SizedBox(height: 10.0,),
                      if(state is SearchLoadingState)
                        LinearProgressIndicator(),
                        SizedBox(height: 20.0,),
                        if(state is SearchSuccessState)
                        Expanded(
                            child:  ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context,index)=>BuildListProducts(SearchCubit.get(context).model.data.data[index],context,OldPrice: false ),
                                separatorBuilder: (context,index)=>myDivider(),
                                itemCount: SearchCubit.get(context).model.data.data.length
                            ),
                        ),
                    ],
              ),
            ),
          )
          );
        },

      ),
    );
  }
}
