import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:politician/Users/Screens/Stream/broadcast_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Events extends StatefulWidget {
  SharedPreferences prefskylo;
  Events({required this.prefskylo});
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late DatabaseReference ref4,ref1;
  late var infos;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref4 = FirebaseDatabase.instance.reference().child("Kyloevents");
    ref1 = FirebaseDatabase.instance.reference().child("Kylousers");
    getData();
  }

  Future getData() async{
    String myUrl="https://kylolivestream.herokuapp.com/access_token?channel=abc";
    var req = await http.get(Uri.parse(myUrl));
    setState(() {
      infos = json.decode(req.body);
    });
    print(infos["token"].runtimeType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,0,0,0),
            child: Text("Events Scheduled",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600
              ),),
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.fromLTRB(0,0,10,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Timer(Duration(seconds:2),(){
                      Map data = <String, dynamic>{
                        "User": FirebaseAuth.instance.currentUser == null
                            ? "Anonymous User"
                            : FirebaseAuth.instance.currentUser!.displayName==null
                            ? "User Signed With Phone Number"
                            : FirebaseAuth.instance.currentUser!.displayName,
                        "Photo": "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png",
                      };
                      ref1.push().set(data).then((value) => print("PUSHED"));
                      onJoin();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffFD7332),
                            width: 2
                        ),
                        borderRadius: BorderRadius.circular(20) // use instead of BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(7,5,7,5),
                      child: Text("Join Stream",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffFD7332),
                            fontWeight: FontWeight.w600),),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-200,
            color: Color(0xffF2F4F6),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  StreamBuilder(
                    stream: ref4.onValue,
                    builder: (context,AsyncSnapshot snap){
                      if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null){
                        Map data = snap.data.snapshot.value;
                        List item = [];
                        data.forEach((index, data)
                        {
                          item.add({"key":index, ...data});
                        }
                        );
                        item.sort((a, b) => a["Postedtime"].compareTo(b["Postedtime"]));
                        return Container(
                          height: MediaQuery.of(context).size.height-210,
                          child: ListView.builder(
                              itemCount: item.length,
                              itemBuilder: (context,index){
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 23,
                                        backgroundColor: Color(0xff0E2936),
                                        child: Icon(Icons.calendar_today,size: 23,),
                                      ),
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("An Event has been scheduled by the party and you are invited to join the event on the respected day",
                                            maxLines: 3,
                                            style: TextStyle(
                                                fontSize: 16
                                            ),
                                          ),
                                          SizedBox(height: 10    ,),
                                          Text(item[index]["Date"],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff848484),
                                            ),),
                                          SizedBox(height: 20,),
                                        ],
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFFFD7332),
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                            ),
                                            child: Center(
                                                child: Text("Got It",
                                                  textScaleFactor: 1
                                                  ,style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600),)),
                                          ),
                                          SizedBox(width: 10,),
                                          GestureDetector(
                                            onTap: (){
                                              showDialog(context: context, builder: (context){
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20.0),
                                                  ),
                                                  title: Text("Event Details",textScaleFactor: 1),
                                                  content: Text("${item[index]["Event"]}",style: TextStyle(fontSize: 18),),
                                                  actions: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(14.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          GestureDetector(
                                                              onTap:(){
                                                                Navigator.pop(context);
                                                              },
                                                              child: Text("Ok",textScaleFactor: 1,style: TextStyle(fontSize: 18),)),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                            },
                                            child: Container(
                                              width: 130,
                                              height: 30,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFFFFD011),
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              ),
                                              child: Center(
                                                  child: Text("Check Details",
                                                    textScaleFactor: 1
                                                    ,style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600),)),
                                            ),
                                          ),

                                        ],
                                      ),
                                      trailing: Padding(
                                        padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                        child: GestureDetector(
                                            onTap: (){
                                              Share.share(item[index]["Event"]+'.So You are requested to join the event'
                                                  , subject: 'An Event has been Scheduled');
                                            },
                                            child: CircleAvatar(
                                                radius: 18,
                                                backgroundColor: Colors.green,
                                                child: Icon(Icons.share,color: Colors.white,size: 20,))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20,20,10,20),
                                      child: Divider(
                                        thickness: 1,
                                      ),
                                    )
                                  ],
                                );
                              }),
                        );
                      }
                      else {
                        return Container(
                            height: 500,
                            child: Center(
                                child: Text("No Events Currently",
                                  style: TextStyle(fontSize: 25),)
                            )
                        );
                      }
                    },
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> onJoin() async {
    await [Permission.camera, Permission.microphone].request();
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BroadcastPage(
          channelName: "abc",
          token:infos["token"],
          isBroadcaster: false,
          prefskylo: widget.prefskylo,
        )
        )
    );
  }
}
