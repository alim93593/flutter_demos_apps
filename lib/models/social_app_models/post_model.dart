class PostModel{
  String name;
  String image;
  String uId;
  String datetime;
  String text;
  String postimge;
  PostModel({this.name,this.uId,this.image,this.datetime,this.text,this.postimge});
  PostModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    datetime = json['datetime'];
    text = json['text'];
    postimge = json['postimge'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'uId':uId,
      'image':image,
      'datetime':datetime,
      'text':text,
      'postimge':postimge,
    };
  }
}