import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:politician/POLITICIAN/Screens/Authentication/signin.dart';
import 'package:politician/Splash/Splashnext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  late SharedPreferences prefskylo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialise();
  }
  initialise() async {
    prefskylo=await SharedPreferences.getInstance();
  }
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
                    Text("Svagatam",
                      textScaleFactor: 1,
                      style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600),)
                  ],
                ),
                SizedBox(height: 20,),
                Text("Welcome to the National Party App ",
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600),),
                SizedBox(height: 15,),
                Text("Connect with your favourite politicians",
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => splashnext(prefskylo:prefskylo)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width-50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFD011),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                        child: Text("Log In",
                            textScaleFactor: 1,
                          style: TextStyle(color: Color(0xFF6C6C6C),fontSize: 20,fontWeight: FontWeight.w700),)),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                    width: MediaQuery.of(context).size.width-50,
                    height: 15,
                    alignment: Alignment.bottomRight,
                    child: Text("",textScaleFactor: 1,)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
