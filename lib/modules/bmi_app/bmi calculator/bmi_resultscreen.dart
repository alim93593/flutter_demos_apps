// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {

  final int result;
  final bool isMale;
  final int age;
  BMIResultScreen({Key key,@required this.result, @required this.age,@required this.isMale}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          icon: Icon( Icons.arrow_back_ios_outlined),
          onPressed: (){
            Navigator.pop(context);
        },),

        title: Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5.0,),
            Text(
              'Gender : ${isMale ? 'MALE':'FEMALE'}',
              style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),
            ),
            Text(
              'Result : $result',
              style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),
            ),
            Text(
              'Age : $age',
              style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
