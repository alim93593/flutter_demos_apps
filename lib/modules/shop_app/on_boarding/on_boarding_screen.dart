// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_cast, must_be_immutable, non_constant_identifier_names, unnecessary_string_interpolations, override_on_non_overriding_member, avoid_print


import 'package:flutter/material.dart';
import 'package:flutter_demo/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_demo/shared/componnents/componnents.dart';
import 'package:flutter_demo/shared/network/local/cache_helper.dart';
import 'package:flutter_demo/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel(
    {
    @required this.title,
    @required this.body,
    @required this.image
    }
    );
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
    List<BoardingModel> boarding =[
    BoardingModel(title: 'On Board 1 Title', body: 'On Board 1 Body', image: 'assets/images/shoppy.png'),
    BoardingModel(title: 'On Board 2 Title', body: 'On Board 2 Body', image: 'assets/images/shoppy.png'),
    BoardingModel(title: 'On Board 3 Title', body: 'On Board 3 Body', image: 'assets/images/shoppy.png'),
  ];
  bool isLast = false;
  void onsubmit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      print(value);
      if(value!=null){
        navigateandfinish(context, ShopLoginScreen());
      }
    });
  }
  var Boardingcontroller = PageController();
  @override
   Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      actions: [
       defaultTextButton(
           text: 'Skip',
           function: (){
              onsubmit();
           }
         ),
      ],
          ),
       body: Padding(
         padding: EdgeInsets.all(10.0),
         child: Column(
           children: [
             Expanded(
               child: PageView.builder(
                 controller: Boardingcontroller,
                 onPageChanged: (int index){
                   if(index == boarding.length-1){
                     setState(() {
                       isLast = true;
                       print(' last');
                     });
                   }else{
                     setState(() {
                       isLast=false;
                       print('not last');
                     });
                   }
                 },
                 physics: BouncingScrollPhysics(),
                 itemBuilder: (context, index) => buildboardingItem(boarding[index]),
                 itemCount: 3,
               ),
             ),
             SizedBox(
               height: 70,
             ),
             Row(
               children: [
                 SmoothPageIndicator(
                     controller: Boardingcontroller,
                     count: boarding.length,
                     effect:ExpandingDotsEffect(
                       dotColor: Colors.blue,
                       activeDotColor: defaultcolor,
                       dotHeight: 10,
                       dotWidth: 10.0,
                       spacing: 5.0,
                       expansionFactor: 4.0
                     ) ,
                 ),
                 Text(
                   'Indicator',
                   style: TextStyle(fontSize: 18.0),
                 ),
                 Spacer(),
                 FloatingActionButton(
                   onPressed: () {
                     if(isLast){
                      onsubmit();
                     }else{
                       Boardingcontroller.nextPage(
                           duration: Duration(milliseconds: 750),
                           curve: Curves.fastLinearToSlowEaseIn
                       );
                     }
                   },
                   child: Icon(Icons.arrow_forward_ios_sharp),
                 ),
               ],
             ),
           ],
         ),
       ),
     );
   }
   Widget buildboardingItem(BoardingModel Model ) => Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Expanded(
             child: Image(
               image: AssetImage('${Model.image}'),
             ),
           ),
           SizedBox(
             height: 30.0,
           ),
           Text(
             '${Model.title}',
             style: TextStyle(
               fontSize: 24.0,
               // fontWeight: FontWeight.bold,
             ),
           ),
           SizedBox(
             height: 30.0,
           ),
           Text(
             '${Model.body}',
             style: TextStyle(
               fontSize: 18.0,
               // fontWeight: FontWeight.bold
             ),
           ),
           SizedBox(
             height: 30.0,
           ),

           // PageView.builder(itemBuilder: (context,index)=>)
         ],
       );
}
