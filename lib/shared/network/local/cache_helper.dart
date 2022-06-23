import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences sharedprefrence;

  static init() async{
    sharedprefrence = await SharedPreferences.getInstance();
  }
  static Future<bool> putBollean({@required String key,@required value})async{
    return await sharedprefrence.setBool(key, value);
  }
  static bool getBollean({@required String key}){
    return sharedprefrence.getBool(key);
  }
  static  dynamic getData({@required String key}){
    return sharedprefrence.get(key);
  }
  static Future<bool> saveData({@required String key,@required dynamic  value})async{
    if(value is String) return await sharedprefrence.setString(key, value);
    if(value is int) return await sharedprefrence.setInt(key, value);
    if(value is bool) return await sharedprefrence.setBool(key, value);
    return await sharedprefrence.setDouble(key, value);
  }
  static Future<bool> removeData({@required String key})async{
   return await sharedprefrence.remove(key);
  }
}
