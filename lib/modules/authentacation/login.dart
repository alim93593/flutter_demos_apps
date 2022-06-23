// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_print, sized_box_for_whitespace, missing_return

import 'package:flutter/material.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  // GlobalKey formkey = GlobalKey<FormState>;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool ispassword = true;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
         child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOGIN PAGE',
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    'EMAIL',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormFeild(
                    type: TextInputType.emailAddress,
                    controller: emailcontroller,
                    prefix: Icons.email,
                    label: 'E-Mail Address',
                    validate: (String  value){
                      if(value.isEmpty){
                        return 'Email Address must not be empty';
                      }
                      return null;
                    }
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
              defaultFormFeild(
                  type: TextInputType.visiblePassword,
                  controller: passwordcontroller,
                  ispassword: ispassword,
                  sufixpressed: (){
                    setState(() {
                      ispassword = !ispassword;
                    });
                  },
                  prefix: Icons.lock,
                  sufix: ispassword? Icons.visibility:Icons.visibility_off,
                  label: 'Password',
                  validate: (String  value){
                    if(value.isEmpty){
                      return 'Password is too short';
                    }
                    return null;
                  }
              ),
                  SizedBox(
                    height: 25.0,
                  ),
                  defaultButton(
                    text: 'Login',
                    function: (){
                      if(formkey.currentState.validate()) {
                        print(emailcontroller.text);
                        print(passwordcontroller.text);
                      }
                    }
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
                      ),
                      TextButton(
                          onPressed: (){

                          },
                          child: Text('Register Now.',style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,)))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
