// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/shop_app/cubit/states.dart';
import 'package:flutter_demo/models/shop_app_models/categories_model.dart';
import 'package:flutter_demo/models/shop_app_models/change_favorites.dart';
import 'package:flutter_demo/models/shop_app_models/favorite_model.dart';
import 'package:flutter_demo/models/shop_app_models/home_model.dart';
import 'package:flutter_demo/models/shop_app_models/login_model.dart';
import 'package:flutter_demo/modules/shop_app/categories/categories_screen.dart';
import 'package:flutter_demo/modules/shop_app/favorites/favorite_screen.dart';
import 'package:flutter_demo/modules/shop_app/products/products_screen.dart';
import 'package:flutter_demo/modules/shop_app/settings/settings_screen.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/network/end_point.dart';
import 'package:flutter_demo/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopIntialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentindex = 0;
  List<Widget> bottomScreens =[
    ProductScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];
  Map<int,bool>favorites= {};
  void changeBottom(int index){
   currentindex = index;
   emit(ShopChangeBottomNavState());
 }
  HomeModel homeModel;
  void getHomeData(){
   emit(ShopLoadingHomeDataState());
   DioHelper.getData(url: HOME,token: token).then((value) {
     homeModel = HomeModel.fromJson(value.data);
     // print(homeModel.data.banners[0].image);
     homeModel.data.products.forEach((element) {
       favorites.addAll({
         element.id:element.in_favorites
       });
     });
     emit(ShopSuccessHomeDataState());
   }).catchError((error){
     print(error);
     emit(ShopErrorHomeDataState(error.toString()));
   });
 }
  CatogeriesModel catogeriesModel;
  void getCategoriesData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: GET_GATEGORIES,token: token).then((value) {
      catogeriesModel = CatogeriesModel.fromJson(value.data);
      // print(catogeriesModel.data.data[0].image);
      emit(ShopSuccessGatogeriesState());
    }).catchError((error){
      print(error);
      emit(ShopErrorGatogeriesState(error.toString()));
    });
  }
  ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productid){
    favorites[productid] =! favorites[productid];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(url: FAVORITES, data: {
      'product_id':productid
    },
    token: token
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // print(value.data);
      if(!changeFavoritesModel.status){
        favorites[productid] =! favorites[productid];
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error){
      favorites[productid] =! favorites[productid];
      print(error.toString());
      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  FavoriteModel getFavoriteModel;
  void getFavorites(){
    emit(ShopLoadinGetFavoritesState());
    DioHelper.getData(url: FAVORITES,
      token: token
    ).then((value) {
      getFavoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }

  ShopLoginModel userModel;
  void getUserData(){
    emit(ShopLoadinGetUserDataState());
    DioHelper.getData(url: PROFILE,
      token: token
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // print(userModel.data.name);
      emit(ShopSuccessGetUserDataState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState(error));
    });
  }

  void updateUserData({@required String name,@required String phone,@required String email,}){
    emit(ShopLoadinUpdateUserDataState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
         'name':name,
         'phone':phone,
         'email':email
        }
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      if(userModel.status==false){
        showtoast(text:userModel.message , state: ToastStates.ERROR);
      }else{
        showtoast(text:userModel.message , state: ToastStates.SUCCESS);
      }
      emit(ShopSuccessUpdateUserDataState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserDataState(error));
    });
  }
}