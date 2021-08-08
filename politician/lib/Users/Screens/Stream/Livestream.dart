import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:politician/Users/Screens/Stream/broadcast_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Livestream extends StatefulWidget {
  SharedPreferences prefskylo;
  Livestream({required this.prefskylo});
  @override
  _LivestreamState createState() => _LivestreamState();
}

class _LivestreamState extends State<Livestream> {
  late DatabaseReference ref1;
  late var infos;

  Future getData() async{
    String myUrl="https://kylolivestream.herokuapp.com/access_token?channel=abc";
    var req = await http.get(Uri.parse(myUrl));
    setState(() {
      infos = json.decode(req.body);
    });
    print(infos["token"]);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    ref1 = FirebaseDatabase.instance.reference().child("Kylousers");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: (){
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
            },
            child: Text("JOIN"),
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    await [Permission.camera, Permission.microphone].request();
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BroadcastPage(
            channelName: "abc",
            isBroadcaster: false,
            prefskylo:widget.prefskylo,
            token:infos["token"]
        ),
        )
    );

  }
}
