// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, missing_required_param, non_constant_identifier_names, invalid_required_positional_param, constant_identifier_names, missing_return

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_demo/modules/news_app/web_view/web_view_screen.dart';
import 'package:flutter_demo/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_demo/shared/cubit/cubit.dart';
import 'package:flutter_demo/shared/network/local/cache_helper.dart';
import 'package:flutter_demo/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isuppercase = true,
  double radius = 10.0,
  double height=40.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isuppercase ? text.toUpperCase() : text,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white),
        ),
        height: height,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultFormFeild({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onsubmit,
  Function onchanged,
  Function onTap,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData sufix,
  Function sufixpressed,
  bool ispassword = false,
}) =>
    TextFormField(
      keyboardType: type,
      controller: controller,
      onFieldSubmitted: onsubmit,
      onTap: onTap,
      onChanged: onchanged,
      obscureText: ispassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          backgroundColor: Colors.white
        ),
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: sufix != null
            ? IconButton(
                onPressed: sufixpressed,
                icon: Icon(sufix),
              )
            : null,
      ),
      validator: validate,
    );

Widget builditem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Center(
              child: CircleAvatar(
                radius: 40.0,
                child: Text('${model['date']}'),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['time']}',
                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .Updatedatabase(status: 'Done', id: model['id']);
              },
              icon: Icon(
                Icons.check_circle,
                color: Colors.green[500],
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .Updatedatabase(status: 'Archieved', id: model['id']);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteFromDataBase(id: model['id']);
      },
    );
Widget taskBuilder({@required List<Map> tasks}) => ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return builditem(tasks[index], context);
        },
        separatorBuilder: (context, index) {
          return myDivider();
        },
        itemCount: tasks.length, // itemCount: tasks.length
      ),
      fallback: (context) => Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                size: 100.0,
                color: Colors.grey[400],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'NO Tasks Yet, Add Some New Tasks',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
      ),
    );
Widget buildArticleItems(article, context) => InkWell(
        onTap: (){
          navigateto(context, WebViewScreen(article['url']));
        },
        child:   Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(

          children: [

            CachedNetworkImage(

              imageUrl: '${article['urlToImage']}',

              errorWidget: (context, url, error) => Text(

                '!!!!!!!!!!',

                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),

              ),

              imageBuilder: (context, imageprovider) {
                return ImageContainer(url: imageprovider);
              },

            ),

            SizedBox(

              width: 20.0,

            ),

            Expanded(

              child: Container(

                height: 120.0,

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Expanded(

                      child: Text(

                        '${article['title']}',

                        style: Theme.of(context).textTheme.bodyText1,

                        // fontSize: 18.0, fontWeight: FontWeight.w600),

                        maxLines: 4,

                        overflow: TextOverflow.ellipsis,

                      ),

                    ),

                    Text(

                      '${article['publishedAt']}',

                      style: TextStyle(

                          fontSize: 18.0,

                          fontWeight: FontWeight.w600,

                          color: Colors.grey),

                    ),

                  ],

                ),

              ),

            ),

          ],

        ),

      ),
);
Widget myDivider() => Padding(
      padding: EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 2.0,
        color: Colors.grey[300],
      ),
    );
Widget ImageContainer({@required url,double width = 10.0,double containerwidth = 120.0,double containerheight = 120.0,BoxFit boxfit =BoxFit.cover }) => Container(
      width: containerwidth,
      height: containerheight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width),
          image: DecorationImage(image: url, fit: boxfit)),
    );
Widget articlebuilder(list, {@required itemcount,issearch=false}) => ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItems(list[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: itemcount,
        ),
    fallback: (context) => issearch?Container():Center(child: CircularProgressIndicator(),
        ));
void navigateto(context, widget) =>  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateandfinish(context, widget) =>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget),(route){
  return false;
});
Widget defaultTextButton({@required String text,@required Function function})=>TextButton(onPressed: function, child: Text(text.toUpperCase()));
void showtoast({@required String text,@required ToastStates state})=> Fluttertoast.showToast(
    msg:text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates{SUCCESS,ERROR,WARINING}
Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARINING:
      color = Colors.yellowAccent;
      break;
  }
  return color;
}
void SignOut(context){
  CacheHelper.removeData(key: 'token',).then((value) {
    if(value){
      navigateandfinish(context, ShopLoginScreen());
      // print(token);
    }
  });
}
Widget BuildListProducts(model,context,{bool OldPrice=true})=> Padding(
  padding: EdgeInsets.all(10.0),
  child: Container(
    height: 150.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 180.0,
          width:180.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              CachedNetworkImage(
                imageUrl: '${model.image}',
                errorWidget:(context, url, error) => Text(
                  'https://student.valuxapps.com/storage/uploads/banners/1619472351ITAM5.3bb51c97376281.5ec3ca8c1e8c5.jpg',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                imageBuilder: (context, imageprovider) {
                  return ImageContainer(
                      url: imageprovider,
                      containerwidth:160.0,
                      containerheight: 160.0,
                      boxfit: BoxFit.fitHeight
                  );
                },
              ),
              if(model.discount.toString()!= '0'&& OldPrice ==true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child:Text(
                    'Disount  ${model.discount}%',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decorationThickness: 10.0,
                    ),
                  ) ,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(color: Colors.red, spreadRadius: 3),
                      ]
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0,height: 1.7),
              ),
              Spacer(),
              Row(
                children:[
                  Text(
                    '${model.price} EGP',
                    style: TextStyle(fontSize: 12.0,color: defaultcolor,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 3.0,),
                  if(model.discount.toString()!= '0'&& OldPrice ==true)
                    Text(
                      '${model.oldPrice} EGP',
                      style: TextStyle(fontSize: 12.0,color: Colors.grey,fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor:ShopCubit.get(context).favorites[model.id]?defaultcolor: Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      )
                  ),

                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
Widget defaultAppbar({@required BuildContext context,String title,List<Widget> actions})=>AppBar(
    title: Text(title),
   actions: actions,
   leading: IconButton(
    onPressed: (){
     Navigator.pop(context);
    },
     icon: Icon(Icons.keyboard_arrow_left_sharp,size: 40,),
  ),
   titleSpacing: 5.0,
);