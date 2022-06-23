
// ignore_for_file: unused_import, avoid_print, unnecessary_string_interpolations, unnecessary_import, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/models/shop_app_models/login_model.dart';
import 'package:flutter_demo/models/social_app_models/social_user_model.dart';
import 'package:flutter_demo/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_demo/modules/social_app/social_register_screen/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/network/end_point.dart';
import 'package:flutter_demo/shared/network/remote/dio_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit() : super(SocialRegisterIntialState());

  static  SocialRegisterCubit get(context)=>BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool ispassword= true;
  void changepasswordvisibilty(){
    ispassword =! ispassword;
    suffix = ispassword? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibiltyState());
  }
  void userRegister({@required String email,@required String password,@required String name,@required String phone}){
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
        ).then((value){
          // print(value.user.phoneNumber);
          // print(value.user.uid);
          userCreate(email: email, name: name, phone: phone, uId: value.user.uid);
          showtoast(text: 'Register Successfully', state: ToastStates.SUCCESS);
    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString().substring(36)));
    });
  }
  void userCreate({@required String email,@required String name,@required String phone,@required String uId}){
    emit(SocialRegisterLoadingState());
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      bio: 'Write your bio..',
      cover: 'https://www.freepik.com/free-vector/espresso-coffee-cup-coffee-beans_10578326.htm#&position=20&from_view=category',
      image: 'https://www.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_10421502.htm#&position=26&from_view=category',
      isEmailVerified: false
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set( model.toMap()).then((value) {
      showtoast(text: 'Register Successfully', state: ToastStates.SUCCESS);
      emit(SocialSuccessCreateUserState());
    }).catchError((error){
      print(error.toString());
      emit(SocialErrorCreateUserState(error.toString()));
    });


  }
}