// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/social_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/social_app/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';

class NewPostScreen extends StatelessWidget {

var textcontroller = TextEditingController();
var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context,state){
        return Scaffold(
          appBar: defaultAppbar(
              context: context,
              title: 'Create Post',
              actions: [
                defaultTextButton(text: 'Post', function: (){
                  var now = DateTime.now();
                  // if(formkey.currentState.validate()&& textcontroller.text!= null){
                  if(SocialCubit.get(context).postimage==null){
                    SocialCubit.get(context).createpost(datetime: now.toString(), text:textcontroller.text );
                    textcontroller.text="";
                  }else{
                    SocialCubit.get(context).uploadpostimage(datetime:  now.toString(), text:textcontroller.text );
                    textcontroller.text="";
                    SocialCubit.get(context).deletepostimage();
                  }
                // }else{
                //     showtoast(text: 'please enter your post', state: ToastStates.ERROR);
                  // }
             })
              ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                SizedBox(height: 5,),
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        height: 60.0,
                        width: 70.0,
                        color: Colors.grey.shade200,
                        child: Image.asset('assets/images/waist.jpg',
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(child: Text('Ali Mahmoud Ali Hassan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.4)
                    ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: formkey,
                  child: Expanded(
                    child: TextFormField(
                      controller: textcontroller,
                      validator: (String value){
                        if(value.isEmpty){
                          showtoast(text: 'please enter your post', state: ToastStates.ERROR);
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'what is in your mind?',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postimage!=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image:FileImage(SocialCubit.get(context).postimage),
                            fit: BoxFit.fill,
                          )),
                    ),
                    IconButton(onPressed: (){
                      SocialCubit.get(context).deletepostimage();
                    }, icon: CircleAvatar(
                        radius: 20.0,
                        child: Icon(Icons.close,size: 20,))
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getpostimage();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.image_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text('add photo')
                        ],
                      )
                      ),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){
                      },
                          child: Text('# tags')
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },

    );
  }
}
