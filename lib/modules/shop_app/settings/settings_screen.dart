// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/shop_app/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';

class  SettingsScreen extends StatelessWidget {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var formkey=GlobalKey<FormState>();
        var cubit = ShopCubit.get(context);
        var model = cubit.userModel;
        if(model.data != null){
          namecontroller.text =  model.data.name;
          emailcontroller.text=  model.data.email;
          phonecontroller.text = model.data.phone;
        }
        return  ConditionalBuilder(
          builder: (context)=> Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    if(state is ShopLoadinUpdateUserDataState)
                    LinearProgressIndicator(),
                    SizedBox(height: 60.0,),
                    defaultFormFeild(
                        controller: namecontroller,
                        type: TextInputType.name,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Please Enter Your Name';
                          }
                          return null;
                        },
                        label: 'User Name',
                        prefix: Icons.person
                    ),
                    SizedBox(height: 30.0,),
                    defaultFormFeild(
                        controller: emailcontroller,
                        type: TextInputType.emailAddress,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Please Enter Your Email';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined
                    ),
                    SizedBox(height: 30.0,),
                    defaultFormFeild(
                        controller: phonecontroller,
                        type: TextInputType.number,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Please Enter Your Phone';
                          }
                          return null;
                        },
                        label: 'Phone Number',
                        prefix: Icons.phone
                    ),
                    SizedBox(height: 50.0,),
                    defaultButton(
                        function: (){
                          if(formkey.currentState.validate()){
                                cubit.updateUserData(
                                name: namecontroller.text,
                                phone: phonecontroller.text,
                                email: emailcontroller.text);
                          }
                        },
                        text: 'Update'
                    ),
                    SizedBox(height: 20.0,),
                    defaultButton(
                        function: (){
                          SignOut(context);
                        },
                        text: 'LogOut'
                    ),
                  ],
                ),
              ),
            ),
          ),
          condition:cubit.userModel!= null ,
          fallback: (context)=> Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }
}
