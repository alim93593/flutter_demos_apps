// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print, duplicate_ignore, unrelated_type_equality_checks

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/shop_app/cubit/states.dart';
import 'package:flutter_demo/models/shop_app_models/categories_model.dart';
import 'package:flutter_demo/models/shop_app_models/home_model.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/styles/colors.dart';

class  ProductScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoritesState){
          if(state.model.status) {
            showtoast(text: state.model.message, state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return  ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.catogeriesModel!= null,
            builder: (context)=>ProductsBuilder(cubit.homeModel,cubit.catogeriesModel,context),
            fallback: (context)=> Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
  Widget ProductsBuilder(HomeModel model,CatogeriesModel catogey,context)=> SingleChildScrollView(
    physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        CarouselSlider(
            items:model.data.banners.map((e) =>CachedNetworkImage(
              imageUrl: '${e.image}',
              errorWidget:(context, url, error) => Text(
              '!!!!!!!!!!',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
               ),
              imageBuilder: (context, imageprovider) {
                return ImageContainer(url: imageprovider,width: double.infinity,containerwidth: double.infinity,);
              },
              // child: Image(
              //   image:NetworkImage('${e.image}'),
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              //   ),
            ),).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal

            )
        ),
        SizedBox(height: 20.0,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w900),),
              SizedBox(height: 10.0,),
              Container(
                height: 140,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>BuildCatogeryItems(catogey.data.data[index]),
                    separatorBuilder:(context,index) => SizedBox(width: 10.0,),
                    itemCount: catogey.data.data.length,
                ),
              ),
              SizedBox(height: 20.0,),
              Text('New Products',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w900),),
            ],
          ),
        ) ,
        SizedBox(height: 5.0,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount:2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1.0/1.43,
            children: List.generate(model.data.products.length, (index) =>BuildProduct(model.data.products[index],context)),
          ),
        ),
      ],
    ),
  );
  Widget BuildProduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            CachedNetworkImage(
            imageUrl: '${model.image}',
            errorWidget:(context, url, error) => Text(
              '!!!!!!!!!!',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            imageBuilder: (context, imageprovider) {
              return ImageContainer(
                  url: imageprovider,
                  width: double.infinity,
                  containerwidth:double.infinity,
                  containerheight: 200.0,
                  boxfit: BoxFit.contain
              );
            },
          ),
            if(model.discount.toString()!= '0')
            Container(
              height: 20.0,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child:Text(
                'Disount  ${model.discount}%',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decorationThickness: 10.0,
                ),
              ) ,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(color: Colors.red, spreadRadius: 3),
                  ]
            ),
          ),
         ],
        ),
        Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0,height: 1.5),
                ),
                Row(
                  children:[
                    Text(
                      '${model.price.round()} EGP',
                      style: TextStyle(fontSize: 12.0,color: defaultcolor,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 3.0,),
                    if(model.discount.toString()!= '0')
                     Text(
                      '${model.old_price.round()} EGP',
                      style: TextStyle(fontSize: 12.0,color: Colors.grey,fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),
                    ),
                    Spacer(),
                     IconButton(
                         onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id);
                         },
                         icon: CircleAvatar(
                           backgroundColor:ShopCubit.get(context).favorites[model.id]?defaultcolor: Colors.grey,
                           child: Icon(
                               Icons.favorite_border,
                             color: Colors.white,
                           ),
                         )
                     ),

                  ],
                ),
              ],
            ),

        ),
      ],
    ),
  );
  Widget BuildCatogeryItems(DataModel Category)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      CachedNetworkImage(
        imageUrl: '${Category.image}',
        errorWidget:(context, url, error) => Text(
          'Please Check Your Connection',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        imageBuilder: (context, imageprovider) {
          return ImageContainer(
              url: imageprovider,
              width: 120.0,
              containerwidth: 120.0,
              containerheight: 140.0,
              boxfit: BoxFit.contain);
        },
      ),
      Container(
        width: 120,
        color: Colors.black.withOpacity(.8),
        child: Text(
          '${Category.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ],
  );
}
