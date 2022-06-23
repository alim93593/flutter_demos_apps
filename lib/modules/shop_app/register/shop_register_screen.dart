// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/shop_app/shop_layout.dart';
import 'package:flutter_demo/modules/shop_app/register/cubit/cubit.dart';
import 'package:flutter_demo/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/network/end_point.dart';
import 'package:flutter_demo/shared/network/local/cache_helper.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState){
            if(state.Registermodel.status){
              print(state.Registermodel.data.token);
              print(state.Registermodel.message);
              print(state.Registermodel.status);
              CacheHelper.saveData(key: 'token', value: state.Registermodel.data.token).then((value){
                // id = state.Registermodel.data.id;
                token = state.Registermodel.data.token;
                navigateandfinish(context, ShopLayout());
              });
            }
          }
        },
        builder: (context,state){
          var cubit = ShopRegisterCubit.get(context);
          // bool isregist = cubit.Registermodel.status;
          return  Scaffold(
            appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style:Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                            'Register to browese our offers and products',
                            style:Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey
                            )
                        ),
                        SizedBox(height: 15.0,),
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
                            prefix: Icons.person_outline
                        ),
                        SizedBox(height: 20.0,),
                        defaultFormFeild(
                            controller: emailcontroller,
                            type: TextInputType.emailAddress,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Your Email Address';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormFeild(
                            controller: phonecontroller,
                            type: TextInputType.name,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Your Phone';
                              }
                              return null;
                            },
                            label: 'Phone Number',
                            prefix: Icons.phone
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormFeild(
                            controller: passwordcontroller,
                            type: TextInputType.visiblePassword,
                            sufix: Icons.visibility_outlined,
                            sufixpressed: (){
                              cubit.changepasswordvisibilty();
                            },
                            ispassword:cubit.ispassword ,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Your Password';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline
                        ),
                        SizedBox(height: 25.0,),
                        ConditionalBuilder(
                          condition: state is !ShopRegisterLoadingState,
                          builder: (context)=>defaultButton(
                            function: (){
                                if(formkey.currentState.validate()) {
                                     cubit.userRegister(
                                     email: emailcontroller.text,
                                     password: passwordcontroller.text,
                                     phone: phonecontroller.text,
                                     name: namecontroller.text
                                 );
                              }
                            },
                            text: 'Register',
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator(),),
                        ),
                        SizedBox(height: 20.0,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
