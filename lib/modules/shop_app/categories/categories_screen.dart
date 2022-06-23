// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/shop_app/cubit/states.dart';
import 'package:flutter_demo/models/shop_app_models/categories_model.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';

class  CategoriesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
         listener: (context,state){},
         builder:(context,state){
           var cubit = ShopCubit.get(context);
           return ListView.separated(
               physics: BouncingScrollPhysics(),
               itemBuilder: (context,index)=>BuildCatItem(cubit.catogeriesModel.data.data[index]),
               separatorBuilder: (context,index)=>myDivider(),
               itemCount: cubit.catogeriesModel.data.data.length
           );
         } ,
    );
  }
Widget BuildCatItem(DataModel model)=>Padding(
  padding: EdgeInsets.all(20.0),
  child: Row(
    children: [
      CachedNetworkImage(
        imageUrl: '${model.image}',
        errorWidget:(context, url, error) => Image(
            image: NetworkImage(
                'https://student.valuxapps.com/storage/uploads/categories/16300981128XWfI.Group 1548@3x.png')
        ),
        //     Text(
        //   'Please Check Your Connection',
        //   style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        // ),
        imageBuilder: (context, imageprovider) {
          return ImageContainer(
              url: imageprovider,
              width: 80.0,
              containerwidth: 100.0,
              containerheight: 130.0,
              boxfit: BoxFit.fitWidth);
        },
      ),
      SizedBox(width: 30.0,),
      Text('${model.name}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w900),),
      Spacer(),
      Icon(Icons.arrow_forward_ios_sharp)
    ],
  ),
);
}
