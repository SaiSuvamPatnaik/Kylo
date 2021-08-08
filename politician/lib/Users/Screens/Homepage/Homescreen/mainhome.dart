import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:politician/Users/Screens/Homepage/Homescreen/posting.dart';
import 'package:politician/Users/Screens/Homepage/Homescreen/tweets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mainhome extends StatefulWidget {
  SharedPreferences prefskylo;
  bool tweetpressed;
  mainhome({required this.prefskylo,required this.tweetpressed});
  @override
  _mainhomeState createState() => _mainhomeState();
}

class _mainhomeState extends State<mainhome> {
  late DatabaseReference ref3;
  late bool post;
  late String editmsg;
  void initState() {
    super.initState();
    if (widget.tweetpressed==true){
      post=false;
    }
    else{
      post=true;
    }
    ref3 = FirebaseDatabase.instance.reference().child("Kylopost");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/Images/newbgimg.png'),
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOver),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30,70,20,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("Assets/Images/partylogo.svg"),
                      Text("The National Party App",
                          textScaleFactor: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("Party President",
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),),
                  SizedBox(height: 7,),
                  Text("Mr XYZ",
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),),

                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 450,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                    ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              post=true;
                            });
                          },
                          child: Container(
                            color: Color(0xFFFFD011),
                            child: Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0,10,0,10),
                                  child: post==true
                                      ? Text("Post",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),)
                                      : Text("Tweets",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),)
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  post==true ? msgposts(context,ref3,widget.prefskylo) : tweets(context),



                ],
              ),
            )
          ],
        ),

      ),
    );
  }
}
