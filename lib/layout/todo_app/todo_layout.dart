// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, override_on_non_overriding_member, no_logic_in_create_state, unused_local_variable, avoid_print, unnecessary_new, prefer_is_empty, unused_import, must_be_immutable, use_key_in_widget_constructors

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/cubit/cubit.dart';
import 'package:flutter_demo/shared/cubit/states.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {

  var sCaffolld = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
     return BlocProvider(
       create: (BuildContext context)=> AppCubit()..createdatabase(),
       child: BlocConsumer<AppCubit,AppStates>(
         listener: (BuildContext context,AppStates state){
           if(state is InserttoDatabaseState){
             Navigator.pop(context);
           }
         },
         builder: (BuildContext context,AppStates state){
           AppCubit cubit = AppCubit.get(context);
           return Scaffold(
             key: sCaffolld,
             appBar: AppBar(
               title: Text(cubit.titles[cubit.currentindex],style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w900),),
             ),
             floatingActionButton: FloatingActionButton(
               onPressed:  (){
                 if(cubit.isBottomsheetShown){
                   if(formkey.currentState.validate()){
                     cubit.inserttodatabase(title: titlecontroller.text, time: timecontroller.text, date: datecontroller.text);
                     clearTextFormFeild();
                   }
                 }else{
                   sCaffolld.currentState.showBottomSheet((context) =>
                       Container(
                         color: Colors.grey[100],
                         padding: EdgeInsets.all(10.0),
                         child: Form(
                           key: formkey,
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               defaultFormFeild(
                                 controller:titlecontroller,
                                 type: TextInputType.text,
                                 validate: (String  value){
                                   if(value.isEmpty){
                                     return 'Title must not be empty';
                                   }
                                   return null;
                                 },
                                 label:'Task Title' ,
                                 prefix:Icons.title ,
                               ),
                               SizedBox(height: 15.0,),
                               defaultFormFeild(
                                 controller:timecontroller,
                                 type: TextInputType.datetime,
                                 onTap: (){
                                   FocusScope.of(context).requestFocus(new FocusNode());
                                   showTimePicker(
                                       context: context,
                                       initialTime:TimeOfDay.now()).then((value) {
                                     print(value.format(context).toString());
                                     timecontroller.text = value.format(context).toString();
                                   }
                                   );
                                 },
                                 validate: (String  value){
                                   if(value.isEmpty){
                                     return 'Time must not be empty';
                                   }
                                   return null;
                                 },
                                 label:'Task Time' ,
                                 prefix:Icons.watch_later,
                               ),
                               SizedBox(height: 10.0,),
                               defaultFormFeild(
                                 controller:datecontroller,
                                 type: TextInputType.datetime,
                                 onTap: (){
                                   FocusScope.of(context).requestFocus(new FocusNode());
                                   showDatePicker(
                                       context: context,
                                       initialDate:DateTime.now() ,
                                       firstDate:DateTime.now() ,
                                       lastDate: DateTime.parse('2200-12-31')).then((value) {
                                     datecontroller.text = DateFormat.yMMMd().format(value);
                                   });
                                 },
                                 validate: (String  value){
                                   if(value.isEmpty){
                                     return 'Date must not be empty';
                                   }
                                   return null;
                                 },
                                 label:'Task Date' ,
                                 prefix:Icons.calendar_today,
                               ),
                             ],
                           ),
                         ),
                       ),
                     elevation: 15.0,
                   ).closed.then((value){
                     cubit.changeBottomsheetState(isshow: false, icon: Icons.edit);
                   });
                   cubit.changeBottomsheetState(isshow: true, icon: Icons.add);
                 }
               },
               child: Icon(cubit.fabicon),
             ),
             body:ConditionalBuilder(
               condition:state is !GetDatafromDatabaseLoadinstate,
               builder: (context)=>cubit.screens[cubit.currentindex],
               fallback: (context)=>Center(child: CircularProgressIndicator()),
             ) ,
             bottomNavigationBar: BottomNavigationBar(
               type: BottomNavigationBarType.fixed,
               currentIndex:cubit.currentindex,
               onTap: (index){
                 cubit.changeindex(index);
               },
               items: [
                 BottomNavigationBarItem(
                     icon: Icon(Icons.menu),
                     label: 'Tasks'
                 ),
                 BottomNavigationBarItem(
                     icon: Icon(Icons.check_circle_outline),
                     label: 'Done'
                 ),
                 BottomNavigationBarItem(
                     icon: Icon(Icons.archive_outlined),
                     label: 'Archived'
                 ),

               ],),
           );
         },
       )


     );
  }
  clearTextFormFeild(){
    titlecontroller.clear();
    datecontroller.clear();
    timecontroller.clear();
  }
}
