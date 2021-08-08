import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:politician/POLITICIAN/Screens/Homepage/Events/Events.dart';
import 'package:politician/POLITICIAN/Screens/Homepage/Homescreen/mainhome.dart';
import 'package:politician/POLITICIAN/Screens/Homepage/Homescreen/posting.dart';
import 'package:politician/POLITICIAN/Screens/Homepage/Homescreen/tweets.dart';
import 'package:politician/POLITICIAN/Screens/Homepage/Profile/profile.dart';
import 'package:politician/POLITICIAN/Screens/Livestream/Livestream.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Navigation extends StatefulWidget {
  SharedPreferences prefskylo;
  bool tweetpressed;
  Navigation({required this.prefskylo,required this.tweetpressed});
  @override
  _NavigationState createState() => _NavigationState(prefskylo:prefskylo);
}

class _NavigationState extends State<Navigation> {
  SharedPreferences prefskylo;
  _NavigationState({required this.prefskylo});
  int page=0;
  late String message;
  late DatabaseReference ref3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefskylo.setString("Trial", "SAI");
    print(prefskylo.getString("Trial"));
    ref3 = FirebaseDatabase.instance.reference().child("Kylopost");
    page=0;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      mainhome(prefskylo:widget.prefskylo,tweetpressed:widget.tweetpressed),
      Events(prefskylo:widget.prefskylo),
      mainhome(prefskylo:widget.prefskylo,tweetpressed:widget.tweetpressed),
      mainhome(prefskylo:widget.prefskylo,tweetpressed:widget.tweetpressed),
      profile(),
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
            TabItem(icon: Icons.add, title: 'Post'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          onTap: (int i) {
            setState(() {
              page = i;
              print(page);
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
                              MaterialPageRoute(builder: (context) => Navigation(prefskylo: prefskylo,tweetpressed:false)));
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
                              MaterialPageRoute(builder: (context) => Navigation(prefskylo: prefskylo,tweetpressed:true)));
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
            }

            if (page==3){
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  title: Text("Post Message",textScaleFactor: 1),
                  content: TextField(
                    onChanged: (text){
                      message=text;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.edit)
                    ),
                    style: TextStyle(fontSize: 20,color: Colors.black),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: GestureDetector(
                          onTap:(){
                            String datetime = DateTime.now().toString();
                            Map data = <String, dynamic>{
                              "Message": message.toString(),
                              "Like": 0,
                              "Dislike": 0,
                              "Date":datetime
                            };
                            print(message);
                            if (message!=null && message.isNotEmpty==true){
                              ref3.push().set(data).then((value)
                              {
                                message="";
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: Text("OK",textScaleFactor: 1,style: TextStyle(fontSize: 18),)),
                    )
                  ],
                );
              });
            }

          },
        ),
    );
  }

}
