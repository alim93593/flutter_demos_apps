// ignore_for_file: empty_constructor_bodies, non_constant_identifier_names

class HomeModel {
  bool status;
  HomeDataModel data;
  HomeModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data =HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel{
  List<BannerModel> banners=[];
  List<ProductModel> products =[];
  HomeDataModel.fromJson(Map<String,dynamic>json){
    if(json['banners']!= null){
      json['banners'].forEach((element){
        banners.add(BannerModel.fromJson(element));
      });
    }
    if(json['products']!= null){
      json['products'].forEach((element){
        products.add(ProductModel.fromJson(element));
      });
    }
  }
}
class BannerModel{
  int id;
  String image;
  BannerModel.fromJson(Map<String,dynamic>json){
  id = json['id'];
  image = json['image'];
  }
}
class ProductModel{
  int id;
  dynamic old_price;
  dynamic price;
  dynamic discount;
  String image;
  String name;
  bool in_favorites;
  bool in_cart;
  ProductModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    old_price=json['old_price'];
    price=json['price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];
  }
}