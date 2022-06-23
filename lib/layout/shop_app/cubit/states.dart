import 'package:flutter_demo/models/shop_app_models/change_favorites.dart';
import 'package:flutter_demo/models/shop_app_models/login_model.dart';

abstract class ShopStates{}

class ShopIntialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}


class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessGatogeriesState extends ShopStates{}
class ShopErrorGatogeriesState extends ShopStates{
  final String error;
  ShopErrorGatogeriesState(this.error);
}

class ShopChangeFavoritesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates{
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}


class ShopLoadinGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{
  final String error;
  ShopErrorGetFavoritesState(this.error);
}


class ShopLoadinGetUserDataState extends ShopStates{}
class ShopSuccessGetUserDataState extends ShopStates{
  ShopLoginModel loginModel;
  ShopSuccessGetUserDataState(this.loginModel);
}
class ShopErrorGetUserDataState extends ShopStates{
  final String error;
  ShopErrorGetUserDataState(this.error);
}


class ShopLoadinUpdateUserDataState extends ShopStates{}
class ShopSuccessUpdateUserDataState extends ShopStates{
  ShopLoginModel loginModel;
  ShopSuccessUpdateUserDataState(this.loginModel);
}
class ShopErrorUpdateUserDataState extends ShopStates{
  final String error;
  ShopErrorUpdateUserDataState(this.error);
}