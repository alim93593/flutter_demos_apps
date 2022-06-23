// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/social_app/social__layout.dart';
import 'package:flutter_demo/modules/social_app/social_login_screen/cubit/cubit.dart';
import 'package:flutter_demo/modules/social_app/social_login_screen/cubit/states.dart';
import 'package:flutter_demo/modules/social_app/social_register_screen/social_register_screen.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/network/local/cache_helper.dart';


class SocialLoginScreen extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState){
            showtoast(text: state.error, state: ToastStates.ERROR);
          }
          else if(state is SocialLoginSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
              navigateandfinish(context, SocialLayout());
            });
          }
        },
        builder: (context,state){
          var cubit = SocialLoginCubit.get(context);
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
                            'Login Now to communicate with friends',
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
                              if(!value.toString().contains('@')){
                                return 'Please Enter Avalid Email Address';
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
                            label: 'Password',
                            prefix: Icons.lock_outline
                        ),
                        SizedBox(height: 25.0,),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
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
                                  navigateto(context, SocialRegisterScreen());
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
