// ignore_for_file: unused_import, prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, unused_local_variable, curly_braces_in_flow_control_structures
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/layout/news_app/news_layout.dart';
import 'package:flutter_demo/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/shop_app/shop_layout.dart';
import 'package:flutter_demo/layout/social_app/cubit/cubit.dart';
import 'package:flutter_demo/layout/social_app/social__layout.dart';
import 'package:flutter_demo/layout/todo_app/todo_layout.dart';
import 'package:flutter_demo/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_demo/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:flutter_demo/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:flutter_demo/modules/todo_app/new_tasks/newtasks_screen.dart';
import 'package:flutter_demo/shared/cubit/cubit.dart';
import 'package:flutter_demo/shared/cubit/states.dart';
import 'package:flutter_demo/shared/network/end_point.dart';
import 'package:flutter_demo/shared/network/local/cache_helper.dart';
import 'package:flutter_demo/shared/network/remote/dio_helper.dart';
import 'package:flutter_demo/shared/styles/themes.dart';
import 'package:hexcolor/hexcolor.dart';
import 'layout/news_app/cubit/cubit.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');
  if(onBoarding != null){
    if(token != null){widget = ShopLayout();}
    else { widget = ShopLoginScreen();}
  }if(onBoarding == null){
    widget =OnBoardingScreen();
  }
  // else{
  // widget =OnBoardingScreen();
  // }
  // print(token);
  if(uId != null){
    print(uId);
    widget = SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }
  // print(uId);
  runApp( MyApp(
    isDark: isDark,
    startwidget: widget,
  ));
}
class MyApp extends StatelessWidget {
  MyApp({this.isDark,this.startwidget});
  final bool isDark;
  final Widget startwidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => NewsCubit()..getBussiness()..getSports()..getScience()),
        BlocProvider(create:(BuildContext context)=>AppCubit()..changeAppMode(fromShared:isDark),),
        BlocProvider(create:(BuildContext context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData(),),
        BlocProvider(create:(context) => SocialCubit()..getUserData()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode:AppCubit.get(context).isDark? ThemeMode.light:ThemeMode.dark,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: startwidget,
            // startwidget,
          );
        },
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
