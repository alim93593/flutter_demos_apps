// ignore_for_file: avoid_print, non_constant_identifier_names, invalid_required_positional_param, missing_required_param

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/social_app/cubit/states.dart';
import 'package:flutter_demo/models/social_app_models/post_model.dart';
import 'package:flutter_demo/models/social_app_models/social_user_model.dart';
import 'package:flutter_demo/modules/social_app/new_post/new_post_screen.dart';
import 'package:flutter_demo/modules/social_app/social_chats/chats_screen.dart';
import 'package:flutter_demo/modules/social_app/social_feeds/feeds_screen.dart';
import 'package:flutter_demo/modules/social_app/social_settings/settings%20_screen.dart';
import 'package:flutter_demo/modules/social_app/social_users/users%20_screen.dart';
import 'package:flutter_demo/shared/network/end_point.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_stoarge;

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() : super(SocialIntialState());

 static SocialCubit get(context)=> BlocProvider.of(context);
 int currentindex=0;
 List<Widget> screens=[
   FeedsScreen(),
   ChatsScreen(),
   NewPostScreen(),
   UsersScreen(),
   SocialSettingsScreen()
 ];
  List<String> titles=[
   'Home',
   'Chats',
   'Post',
   'Users',
   'Settings'
  ];
 void ChangeBottomnav(int index){
   if(index == 2){
     emit(SocialNewPostState());
   }else{
     currentindex = index;
     emit(SocialChangeBottomNavState());
   }
 }
 SocialUserModel userModel;
 void getUserData(){
   emit(SocialLoadingGetUserState());
   FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
     userModel = SocialUserModel.fromJson(value.data());
     print(userModel);
     emit(SocialSuccessGetUserState());
   }).catchError((error){
     print(error.toString());
     SocialErrorGetUserState(error.toString());
   });
 }

  File profileimage;
  var picker = ImagePicker();
  Future<void> getprofileimage()async{
    final pickedfile = await picker.getImage(source: ImageSource.gallery);
    if(pickedfile != null){
      profileimage = File(pickedfile.path);
      print(pickedfile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else{
      print('No Image Selected....');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File coverimage;
  Future<void> getcoverimage()async{
    final pickedfile = await picker.getImage(source: ImageSource.gallery);
    if(pickedfile != null){
      coverimage = File(pickedfile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else{
      print('No Image Selected....');
      emit(SocialCoverImagePickedErrorState());
    }
  }


  void uploadprofileImage({@required String name,@required String phone,@required  String bio}){
    emit(SocialUserLoadingUpdateState());
    firebase_stoarge.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage.path).pathSegments.last}')
        .putFile(profileimage)
        .then((value) {
          value.ref.getDownloadURL().then((value) {
            updateUser(name:name, phone:phone, bio:bio,image: value);
           // emit(SocialUploadProfileImageSuccessState());
          }).catchError((error){
            emit(SocialUploadProfileImageErrorState());
          });
    }).catchError((error){
      emit(SocialUploadProfileImageErrorState());
    });
  }


  void uploadcoverImage({@required String name,@required String phone,@required  String bio}){
    emit(SocialUserLoadingUpdateState());
    firebase_stoarge.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverimage.path).pathSegments.last}')
        .putFile(coverimage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name:name, phone:phone, bio:bio,cover: value);
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({@required String name,@required String phone,@required  String bio,  String cover,  String image}){
    emit(SocialUserLoadingUpdateState());
      SocialUserModel model = SocialUserModel(
          name: name,
          phone: phone,
          uId: uId,
          bio: bio,
          email:userModel.email,
          cover:cover?? userModel.cover,
          image:image??userModel.image,
          isEmailVerified: false
      );
      FirebaseFirestore.instance.collection('users').doc(userModel.uId)
          .update(model.toMap())
          .then((value) {
           getUserData();
      }).catchError((error){
        emit(SocialUserUpdateErrorState());
      });
    }

  File postimage;
  Future<void> getpostimage()async{
    final pickedfile = await picker.getImage(source: ImageSource.gallery);
    if(pickedfile != null){
      postimage = File(pickedfile.path);
      emit(SocialPostImagePickedSuccessState());
    }else{
      print('No Image Selected....');
      emit(SocialPostImagePickedErrorState());
    }
  }

  Future<void> deletepostimage()async{
     postimage=null;
     emit(SocialCreatePostImageDeleteSuccess());
    }
  void createpost({
    @required  String datetime,
    @required  String text,
    String postimage
  }){
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
        name: userModel.name,
        uId: uId,
        image:userModel.image,
        datetime: datetime,
        text: text,
        postimge: postimage??''
    );
    FirebaseFirestore.instance.collection('posts')
        .add(model.toMap())
        .then((value) {
         emit(SocialCreatePostSuccessState());
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  void uploadpostimage({
    @required  String datetime,
    @required  String text,
  }){
    emit(SocialCreatePostLoadingState());
    firebase_stoarge.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postimage.path).pathSegments.last}')
        .putFile(postimage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createpost(text: text,datetime: datetime,postimage:value );
      }).catchError((error){
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }
}