
// ignore_for_file: unused_import, avoid_print, unnecessary_string_interpolations, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/models/shop_app_models/login_model.dart';
import 'package:flutter_demo/modules/shop_app/login/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/network/end_point.dart';
import 'package:flutter_demo/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginIntialState());

  static  ShopLoginCubit get(context)=>BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool ispassword= true;
  void changepasswordvisibilty(){
    ispassword =! ispassword;
    suffix = ispassword? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibiltyState());
  }
 ShopLoginModel loginmodel;
  void userlogin({@required String email,@required String password}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:{
          'email':email,
          'password':password,
        }
    ).then((value){
     loginmodel= ShopLoginModel.fromJson(value.data);
     print(loginmodel.status);
     print(loginmodel.message);
     if(loginmodel.status==false){
       showtoast(text:loginmodel.message , state: ToastStates.ERROR);
     }else{
       showtoast(text:loginmodel.message , state: ToastStates.SUCCESS);
     }
      emit(ShopLoginSuccessState(loginmodel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}