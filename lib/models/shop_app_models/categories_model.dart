


// ignore_for_file: non_constant_identifier_names

class CatogeriesModel{
  bool status;
  CtogeriesDataModel data;
  CatogeriesModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data = CtogeriesDataModel.fromJson(json['data']);
  }
}
class CtogeriesDataModel{
  int current_page;
  List<DataModel>data=[];
  CtogeriesDataModel.fromJson(Map<String,dynamic>json){
    current_page = json['current_page'];
    if(json['data']!= null){
      json['data'].forEach((element){
        data.add(DataModel.fromJson(element));
      });
    }
  }
}
class DataModel{
  int id;
  String name;
  String image;
  DataModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}