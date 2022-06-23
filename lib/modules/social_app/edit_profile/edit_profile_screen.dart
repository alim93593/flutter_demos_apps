// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations, must_be_immutable, avoid_print, unused_import, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/social_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/social_app/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  var name = TextEditingController();
  var bio = TextEditingController();
  var phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = SocialCubit.get(context).userModel;
        var profileimage = SocialCubit.get(context).profileimage;
        var coverimage = SocialCubit.get(context).coverimage;
        name.text = usermodel .name;
        bio.text =usermodel.bio;
        phone.text =usermodel.phone;
        return Scaffold(
          appBar:defaultAppbar(
              context: context,
              title: 'Edit Profile',
              actions: [
               defaultTextButton(text: 'Update', function: () {
                 if(SocialCubit.get(context).profileimage!= null){
                   SocialCubit.get(context).uploadprofileImage(name: name.text, phone: phone.text, bio: bio.text);
                   return;
                 }
                 if(SocialCubit.get(context).coverimage!= null){
                   SocialCubit.get(context).uploadcoverImage(name: name.text, phone: phone.text, bio: bio.text);
                   return;
                 }
                 if(SocialCubit.get(context).profileimage== null||SocialCubit.get(context).coverimage== null){
                   SocialCubit.get(context).updateUser(name: name.text,phone: phone.text,bio: bio.text );
                   print('ok');
                 }
               }),
               SizedBox(width: 10.0)
            ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  if(state is SocialUserLoadingUpdateState)
                  LinearProgressIndicator(),
                  // if(state is SocialUserLoadingUpdateState)
                  // SizedBox(height: 10,),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0)),
                                    image: DecorationImage(
                                      image:coverimage==null? NetworkImage('${usermodel.cover}'):FileImage(coverimage),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              IconButton(onPressed: (){
                                SocialCubit.get(context).getcoverimage();
                              }, icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(Icons.add_a_photo_rounded,size: 20,))
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage:profileimage== null? NetworkImage('${usermodel.image}'):FileImage(profileimage),
                              ),
                            ),
                            IconButton(onPressed: (){
                              SocialCubit.get(context).getprofileimage();
                            }, icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(Icons.add_a_photo_rounded,size: 20,))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // SizedBox( height: 15.0),
                  // if(SocialCubit.get(context).profileimage!= null||SocialCubit.get(context).coverimage!= null)
                  // Row(
                  //   children: [
                  //     if(SocialCubit.get(context).profileimage!= null)
                  //     Expanded(
                  //         child: Column(
                  //           children: [
                  //             defaultButton(function: (){
                  //               SocialCubit.get(context).uploadprofileImage(name: name.text, phone: phone.text, bio: bio.text);
                  //             },
                  //           text: 'upload profile'),
                  //             if(state is SocialUserLoadingUpdateState)
                  //           SizedBox( height: 5.0),
                  //             if(state is SocialUserLoadingUpdateState)
                  //           LinearProgressIndicator()
                  //           ],
                  //         )
                  //     ),
                  //     // SizedBox( width: 5.0),
                  //     // if(SocialCubit.get(context).coverimage!= null)
                  //     // Expanded(
                  //     //     child: Column(
                  //     //       children: [
                  //     //         defaultButton(function: (){
                  //     //           SocialCubit.get(context).uploadcoverImage(name: name.text, phone: phone.text, bio: bio.text);
                  //     //         },
                  //     //         text: 'upload cover'),
                  //     //         if(state is SocialUserLoadingUpdateState)
                  //     //         SizedBox( height: 5.0),
                  //     //         if(state is SocialUserLoadingUpdateState)
                  //     //         LinearProgressIndicator()
                  //     //       ],
                  //     //     )
                  //     // ),
                  //   ],
                  // ),
                  // if(SocialCubit.get(context).profileimage!= null||SocialCubit.get(context).coverimage!= null)
                  // SizedBox( height: 25.0),
                  defaultFormFeild(
                      controller: name,
                      type: TextInputType.name,
                      validate: (String value){
                        if(value.isEmpty){
                          return 'Name Must not be Empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.supervised_user_circle
                  ),
                  SizedBox( height: 15.0),
                  defaultFormFeild(
                      controller: bio,
                      type: TextInputType.name,
                      validate: (String value){
                        if(value.isEmpty){
                          return 'BIO Must not be Empty';
                        }
                        return null;
                      },
                      label: 'BIO',
                      prefix: Icons.info_outlined
                  ),
                  SizedBox( height: 15.0),
                  defaultFormFeild(
                      controller: phone,
                      type: TextInputType.number,
                      validate: (String value){
                        if(value.isEmpty){
                          return 'Phone Must not be Empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
