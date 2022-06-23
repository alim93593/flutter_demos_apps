// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print, prefer_is_empty, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/news_app/cubit/states.dart';
import 'package:flutter_demo/modules/news_app/business/business_screen.dart';
import 'package:flutter_demo/modules/news_app/science/science_screen.dart';
import 'package:flutter_demo/modules/news_app/sports/sports_screen.dart';

import 'package:flutter_demo/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super(NewsIntialState());
  static NewsCubit get(context)=> BlocProvider.of(context);
  int currentindex = 0;
  List <dynamic> bussiness =[];
  List <dynamic> sports =[];
  List <dynamic> scinces =[];
  List <dynamic> search =[];

  List<BottomNavigationBarItem> bottomitems=[
    BottomNavigationBarItem(
        icon: Icon(Icons.business_sharp),
       label: 'Bussnies'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'science'
    ),
    // BottomNavigationBarItem(
    //     icon: Icon(Icons.settings),
    //     label: 'Setting'
    // ),
  ];
  List<Widget> Screens =[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingScreen(),
  ];
  void changeBottomNavBar(int index){
    currentindex = index;
    if(index == 1){
      getSports();
    }else if(index == 2){
      getScience();
    }
    emit(NewsBottomNavState());
  }
  void getBussiness(){
    emit(NewsBussinesLoadingState());
    if(bussiness.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apikey': '6a6d5d702152405b84504fe69cfd3d5a',
      }).then((value) {
        bussiness = value.data['articles'];
        print(bussiness[0]['title'].toString());
        emit(NewsBussinesSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsBussinesErrorState(error.toString()));
      });
    }else{
      emit(NewsBussinesSuccessState());
    }
  }
  void getSports(){
    emit(NewsSportsLoadingState());
    if(sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apikey': '6a6d5d702152405b84504fe69cfd3d5a',
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title'].toString());
        emit(NewsSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsSportsErrorState(error));
      });
    }else{
      emit(NewsSportsSuccessState());
    }
  }
  void getScience(){
    if(scinces.isEmpty) {
      emit(NewsScineceLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apikey': '6a6d5d702152405b84504fe69cfd3d5a',
      }).then((value) {
        scinces = value.data['articles'];
        print(scinces[0]['title'].toString());
        emit(NewsScineceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsScineceErrorState(error));
      });
    }
    else{
      emit(NewsScineceSuccessState());
    }
  }
  void getSearch( String value){
    search =[];
      emit(NewsSearchLoadingState());
      DioHelper.getData(url: 'v2/everything', query: {
        'q': '$value',
        'apikey': '6a6d5d702152405b84504fe69cfd3d5a',
      }).then((value) {
        search = value.data['articles'];
        // print(search[0]['title'].toString());
        emit(NewsSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsSearchErrorState(error));
      });
    }

}
