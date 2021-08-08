import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:politician/POLITICIAN/Screens/Authentication/signin.dart';
import 'package:politician/Users/Bottomnavigation/Navigation.dart';
import 'package:politician/Users/Screens/Authentication/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashnext extends StatefulWidget {
  late SharedPreferences prefskylo;
  splashnext({required this.prefskylo});
  @override
  _splashnextState createState() => _splashnextState();
}

class _splashnextState extends State<splashnext> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOver),
            image: AssetImage('Assets/Images/newbgimg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30,0,20,0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFFC4C4C4),
                      child: SvgPicture.asset("Assets/Images/namaskar.svg",color: Colors.black,width: 20,),
                    ),
                    SizedBox(width: 10,),
                    Text("Welcome",
                      textScaleFactor: 1,
                      style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600),)
                  ],
                ),
                SizedBox(height: 10,),
                Text("Welcome to the National Party App ",
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w400),),
                SizedBox(height: 35,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => signin(prefskylo:widget.prefskylo)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width-50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFD011),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                        child: Text("I am a Politician",
                          textScaleFactor: 1,
                          style: TextStyle(color: Color(0xFF6C6C6C),fontSize: 20,fontWeight: FontWeight.w700),)),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Divider(
                        thickness: 1,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text("Or",style: TextStyle(fontSize:20 ,color: Colors.white),),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 1,
                      child: Divider(
                        thickness: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    if (FirebaseAuth.instance.currentUser==null){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => signinuser(prefskylo:widget.prefskylo)));
                    }
                    else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Navigation(prefskylo:widget.prefskylo,tweetpressed:false)));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width-50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFD011),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                        child: Text("I am an User",
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: Color(0xFF6C6C6C),
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
