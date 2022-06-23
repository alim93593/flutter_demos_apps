// ignore_for_file: unnecessary_null_in_if_null_operators, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
 static Dio dio;
 static init(){
    dio = Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true ,
        // headers: {'Content-Type':'application/json'}
      )
    );
  }
 static Future<Response> getData({
   @required String url,
   Map<String,dynamic> query,
   String lang ='en',
   String token,
   int id
 }) async{
   dio.options.headers={
   'Content-Type':'application/json',
   'lang':lang,
   'Authorization':token??'',
 };
   return await dio.get(
     url,
     queryParameters: query??null
 );
 }
 static Future<Response> putData({
   @required String url,
   Map<String,dynamic> query,
   @required Map<String,dynamic> data,
   String lang ='en',
   String token,
   int id
 }) async{
   dio.options.headers={
     'Content-Type':'application/json',
     'lang':lang,
     'Authorization':token??'',
   };
   return await dio.put(
       url,
       queryParameters: query??null,
       data: data
   );
 }

 static Future<Response> postData({
   @required String url,
   Map<String,dynamic> query,
   @required Map<String,dynamic> data,
   String lang ='en',
   String token,
   int id
 })async{
   dio.options.headers ={
     'Content-Type':'application/json',
     'lang':lang,
     'Authorization':token??''
   };
   return await dio.post(
       url,
       queryParameters: query??null,
       data: data
   );
 }
}