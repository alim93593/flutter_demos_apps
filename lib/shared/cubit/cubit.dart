// ignore_for_file: unnecessary_import, prefer_const_constructors, avoid_print, non_constant_identifier_names, unnecessary_string_interpolations, avoid_function_literals_in_foreach_calls

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/modules/todo_app/archived_tasks/archivedtasks_screen.dart';
import 'package:flutter_demo/modules/todo_app/done_tasks/donetasks_screen.dart';
import 'package:flutter_demo/modules/todo_app/new_tasks/newtasks_screen.dart';
import 'package:flutter_demo/shared/cubit/states.dart';
import 'package:flutter_demo/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());
  IconData fabicon = Icons.edit;
  bool isBottomsheetShown = false;

  static AppCubit get(context) => BlocProvider.of(context);
  Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];
  int currentindex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArichivedTasksScreen()
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks'
  ];
  void changeindex(int index) {
    currentindex = index;
    emit(AppChangeBottomNavBar());
  }
  void createdatabase() {
    // deleteDatabase("todo.db");
    // print('deleted success');
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) async {
          print('database created');
          await database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
              .then((value) {
            print('table has been created');
          }).catchError((error) {
            print('Error When Creating Table${error.toString()}');
          });
        },
        onOpen: (database) {
          getDataFromdatabase(database);
          print('database opend');
        }
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }
  void inserttodatabase({@required String title, @required String time, @required String date}) async {
    await database.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO tasks (title,date,time,status) VALUES("$title","$time","$date","new")')
          .then((value) {
        emit(InserttoDatabaseState());
        print('$value inserted successfully');
        getDataFromdatabase(database);
      }).catchError((error) {
        print('Error When Insert Record${error.toString()}');
      });
      return null;
    });
  }
  void getDataFromdatabase(database) {
    newtasks = [];
    archivetasks = [];
    donetasks = [];

    emit(GetDatafromDatabaseLoadinstate());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newtasks.add(element);
        } else if (element['status'] == 'Done') {
          donetasks.add(element);
        } else {
          archivetasks.add(element);
        }
      });
      emit(GetDatafromDatabaseState());
    });
  }
  void Updatedatabase({@required String status, @required int id}) async {
    database.rawUpdate('UPDATE tasks Set status = ? WHERE id=?',
        ['$status', id]).then((value) {
      print('database updated');
      getDataFromdatabase(database);
      emit(UpdateDataBaseState());
    });
  }
  void changeBottomsheetState({@required bool isshow, @required IconData icon}) {
    isBottomsheetShown = isshow;
    fabicon = icon;
    emit(AppChangeBottomSheetState());
  }
  void deleteFromDataBase({@required int id}) {
    database.rawDelete('DELETE FROM tasks WHERE id =?',[id]).then((value) {
      print('database deleted');
      getDataFromdatabase(database);
      emit(DeleteDataBaseState());
    });
  }

  bool isDark = false;
  // ThemeMode appmode = ThemeMode.dark;
  void changeAppMode({bool fromShared}){
    if(fromShared!= null){
      isDark = fromShared;
    }else{
      isDark =!isDark;
    }
    CacheHelper.putBollean(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeModeState());
    });

  }
}