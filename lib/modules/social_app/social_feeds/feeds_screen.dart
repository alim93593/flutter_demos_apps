// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_demo/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
            margin: EdgeInsets.all(8.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: AssetImage(
                      'assets/images/woman-wearing-bathing-suit-color-year-2022.jpg'),
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Commnucation With Friends',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index)=> buildPostItem(context),
              separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
              itemCount: 10
          ),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }
  Widget buildPostItem(context)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    elevation: 5.0,
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: Container(
                  height: 60.0,
                  width: 70.0,
                  color: Colors.grey.shade200,
                  child: Image.asset('assets/images/waist.jpg',
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              // CircleAvatar(
              //   radius: 25.0,
              //   backgroundImage: AssetImage(
              //       'assets/images/woman-wearing-bathing-suit-color-year-2022.jpg'),
              // ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Ali Mahmoud Ali Hassan',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.4)
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: defaultcolor,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text('January 21,2022 at 11:00 pm',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(height: 1.4)
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              IconButton(
                  onPressed: (){},
                  icon:Icon(Icons.more_horiz)
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            'my name is ali safnga and i love sex tooo much my name is ali safnga and i love sex tooo much my name is ali safnga and i love sex tooo much my name is ali safnga and i love sex tooo much my name is ali safnga and i love sex tooo much my name is ali safnga and i love sex tooo much',
            style: TextStyle(height: 1.4,fontSize: 14.0,fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0,top: 5.0),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 6.0),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                          onPressed: (){},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            'Flutter',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                color: defaultcolor
                            ),
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 6.0),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                          onPressed: (){},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            'SofWare',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                color: defaultcolor
                            ),
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 140.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image:AssetImage(
                      'assets/images/waist.jpg'),
                  fit: BoxFit.fill,
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding:EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border,size: 18.0,color: Colors.red,),
                          SizedBox(width: 5.0,),
                          Text(
                            '1200',
                            style: TextStyle(height: 1.4,fontSize: 14.0,fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding:EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.chat_bubble_outline,size: 18.0,color: Colors.amber,),
                          SizedBox(width: 5.0,),
                          Text(
                            '1000',
                            style: TextStyle(height: 1.4,fontSize: 14.0,fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          height: 60.0,
                          width: 70.0,
                          color: Colors.grey.shade200,
                          child: Image.asset(
                            'assets/images/waist.jpg',
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      // CircleAvatar(
                      //   radius: 25.0,
                      //   backgroundImage: AssetImage(
                      //       'assets/images/woman-wearing-bathing-suit-color-year-2022.jpg'),
                      // ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Write acomment',
                        style: TextStyle(height: 1.4,fontSize: 17.0,fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(Icons.favorite_border,size: 18.0,color: Colors.red,),
                    SizedBox(width: 5.0,),
                    Text(
                      'Like',
                      style: TextStyle(height: 1.4,fontSize: 17.0,fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                onTap: (){},
              ),
            ],
          ),

        ],
      ),
    ),
  );
}
