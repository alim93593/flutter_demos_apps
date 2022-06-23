
// ignore_for_file: unused_import, avoid_print, unnecessary_string_interpolations, unnecessary_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/models/shop_app_models/login_model.dart';
import 'package:flutter_demo/modules/shop_app/login/cubit/states.dart';
import 'package:flutter_demo/modules/social_app/social_login_screen/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/network/end_point.dart';
import 'package:flutter_demo/shared/network/remote/dio_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit() : super(SocialLoginIntialState());

  static  SocialLoginCubit get(context)=>BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool ispassword= true;
  void changepasswordvisibilty(){
    ispassword =! ispassword;
    suffix = ispassword? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibiltyState());
  }

  void userlogin({@required String email,@required String password}){
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      print(value.user);
      showtoast(text: 'Login Successfully', state: ToastStates.SUCCESS);
      emit(SocialLoginSuccessState(value.user.uid));
    }).catchError((error){
        print(error.toString());
        emit(SocialLoginErrorState(error.toString().substring(30)));
    });
  }
}