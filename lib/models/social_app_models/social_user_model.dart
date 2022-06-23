class SocialUserModel{
  String name;
  String email;
  String phone;
  String image;
  String uId;
  String bio;
  String cover;
  bool isEmailVerified;
  SocialUserModel({this.name,this.email,this.phone,this.uId,this.isEmailVerified,this.image,this.bio,this.cover});
  SocialUserModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    isEmailVerified=json['isEmailVerified'];
    bio= json['bio'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'bio':bio,
      'cover':cover??''
    };
  }
}