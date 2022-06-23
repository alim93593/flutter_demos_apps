
// ignore_for_file: unused_import, avoid_print, unnecessary_string_interpolations, unnecessary_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/models/shop_app_models/login_model.dart';
import 'package:flutter_demo/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/network/end_point.dart';
import 'package:flutter_demo/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterIntialState());

  static  ShopRegisterCubit get(context)=>BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool ispassword= true;
  void changepasswordvisibilty(){
    ispassword =! ispassword;
    suffix = ispassword? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibiltyState());
  }
 ShopLoginModel Registermodel;
  void userRegister({@required String email,@required String password,@required String name,@required String phone}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:{
          'email':email,
          'password':password,
          'name':name,
          'phone':phone
        }
    ).then((value){
     Registermodel= ShopLoginModel.fromJson(value.data);
     print(Registermodel.status);
     print(Registermodel.message);
     if(Registermodel.status==false){
       showtoast(text:Registermodel.message , state: ToastStates.ERROR);
     }else{
       showtoast(text:Registermodel.message , state: ToastStates.SUCCESS);
     }
      emit(ShopRegisterSuccessState(Registermodel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  // ShopLoginModel userModel;
  // void getUserData(){
  //   emit(ShopLoadinGetUserDataState());
  //   DioHelper.getData(url: PROFILE,
  //       token: token
  //   ).then((value) {
  //     userModel = ShopLoginModel.fromJson(value.data);
  //     // print(userModel.data.name);
  //     emit(ShopSuccessGetUserDataState(userModel));
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(ShopErrorGetUserDataState(error));
  //   });
  // }
}