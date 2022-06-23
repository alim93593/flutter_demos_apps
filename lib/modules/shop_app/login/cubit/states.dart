

import 'package:flutter_demo/models/shop_app_models/login_model.dart';

abstract class ShopLoginStates {}


class ShopLoginIntialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopLoginSuccessState extends ShopLoginStates{
  final ShopLoginModel loginmodel;
  ShopLoginSuccessState(this.loginmodel);
}

class ShopChangePasswordVisibiltyState extends ShopLoginStates{}