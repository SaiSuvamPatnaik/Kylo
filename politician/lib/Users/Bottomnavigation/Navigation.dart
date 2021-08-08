import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:politician/Users/Screens/Details/Details.dart';
import 'package:politician/Users/Screens/Homepage/Events/Events.dart';
import 'package:politician/Users/Screens/Homepage/Homescreen/mainhome.dart';
import 'package:politician/Users/Screens/Homepage/UserProfile/profile.dart';
import 'package:politician/Users/Screens/Stream/Livestream.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navigation extends StatefulWidget {
  SharedPreferences prefskylo;
  bool tweetpressed;
  Navigation({required this.prefskylo,required this.tweetpressed});
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  int page=0;
  late String message;
  late DatabaseReference ref3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref3 = FirebaseDatabase.instance.reference().child("Kylotwitter");
    page=0;
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      mainhome(prefskylo:widget.prefskylo,tweetpressed: widget.tweetpressed),
      Events(prefskylo:widget.prefskylo),
      mainhome(prefskylo:widget.prefskylo,tweetpressed:widget.tweetpressed),
      Details(),
      profile(prefskylo:widget.prefskylo),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: tabs[page],
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.white,
          activeColor: Colors.black,
          color: Colors.black,
          initialActiveIndex: 0,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.calendar_today, title: 'Events'),
            TabItem(icon: Icons.message, title: 'Media'),
            TabItem(icon: Icons.dashboard, title: 'About'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          onTap: (int i) {
            setState(() {
              page = i;
            });

            if (page==2){
              showDialog(context: context, builder: (context){
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          print("TAPPED");
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Navigation(prefskylo: widget.prefskylo,tweetpressed:false)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffFD7322),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12,7,12,7),
                            child: Text("Posts",style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                decoration: TextDecoration.none

                            ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 60,),
                      GestureDetector(
                        onTap: (){
                          print("TWEET TAP");
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Navigation(prefskylo: widget.prefskylo,tweetpressed:true)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffFD7322),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12,7,12,7),
                            child: Text("Tweets",style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                decoration: TextDecoration.none
                            ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
            };

          },



        ),
    );
  }
}
