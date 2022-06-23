// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultcolor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
    elevation: 20.0,
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch:defaultcolor,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.white, size: 25.0),
    titleTextStyle: TextStyle(
        fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white
    ),
  ),
  fontFamily: 'Jannah'
);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch:defaultcolor ,
  // inputDecorationTheme: InputDecorationTheme(
  // hintStyle: TextStyle(color: Colors.red),
  // labelStyle: TextStyle(color:Colors.red )
  // ),
  // primaryColor: Colors.redAccent,
  // primaryColorDark: Colors.red,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black, size: 25.0),
    titleTextStyle: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Jannah'
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0.0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    // backgroundColor: Colors.blue
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultcolor,
    elevation: 20.0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black
    ),
  ),
  fontFamily: 'Jannah'
);