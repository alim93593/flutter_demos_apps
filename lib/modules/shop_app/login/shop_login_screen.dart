// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/shop_app/shop_layout.dart';
import 'package:flutter_demo/modules/shop_app/login/cubit/cubit.dart';
import 'package:flutter_demo/modules/shop_app/login/cubit/states.dart';
import 'package:flutter_demo/modules/shop_app/register/shop_register_screen.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/network/end_point.dart';
import 'package:flutter_demo/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState){
            if(state.loginmodel.status){
                CacheHelper.saveData(key: 'token', value: state.loginmodel.data.token).then((value){
                token= state.loginmodel.data.token;
                navigateandfinish(context, ShopLayout());
                print(token);
              });
            }
          }
        },
        builder: (context,state){
         var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'LOGIN',
                            style:Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black
                            ),
                        ),
                        Text(
                            'Login to browese our offers and products',
                            style:Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey
                            )

                        ),
                        SizedBox(height: 30.0,),
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
                            onsubmit: (value){
                              // if(formkey.currentState.validate()){
                              //   cubit.userlogin(email: emailcontroller.text, password: passwordcontroller.text);
                              // }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline
                        ),
                        SizedBox(height: 25.0,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=>defaultButton(
                            function: (){
                              if(formkey.currentState.validate()){
                                cubit.userlogin(email: emailcontroller.text, password: passwordcontroller.text);
                              }
                            },
                            text: 'Login',
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator(),),
                        ),
                        SizedBox(height: 20.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Don\'t have an account?',
                                style:Theme.of(context).textTheme.bodyText1.copyWith(
                                    color: Colors.black
                                )
                            ),
                            defaultTextButton(
                                text: 'register now',
                                function: (){
                                  navigateto(context, ShopRegisterScreen());
                                }
                            ),

                          ],
                        ),
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
