

// ignore_for_file: non_constant_identifier_names


import 'package:flutter_demo/models/shop_app_models/login_model.dart';

abstract class ShopRegisterStates {}


class ShopRegisterIntialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterSuccessState extends ShopRegisterStates{
  final ShopLoginModel Registermodel;
  ShopRegisterSuccessState(this.Registermodel);
}


class ShopRegisterChangePasswordVisibiltyState extends ShopRegisterStates{}

class ShopLoadinGetUserDataState extends ShopRegisterStates{}
class ShopSuccessGetUserDataState extends ShopRegisterStates{
  ShopLoginModel loginModel;
  ShopSuccessGetUserDataState(this.loginModel);
}
class ShopErrorGetUserDataState extends ShopRegisterStates{
  final String error;
  ShopErrorGetUserDataState(this.error);
}