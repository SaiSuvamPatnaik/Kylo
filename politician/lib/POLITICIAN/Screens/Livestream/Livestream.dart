import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:politician/POLITICIAN/Screens/Livestream/broadcast_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Livestream extends StatefulWidget {
  SharedPreferences prefskylo;
  Livestream({required this.prefskylo});
  @override
  _LivestreamState createState() => _LivestreamState();
}

class _LivestreamState extends State<Livestream> {
  late var infos;

  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: (){
              Timer(Duration(seconds:2),(){
                onJoin();
              });
            },
            child: Text("START"),
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
          Token:infos["token"],
          isBroadcaster: true,
          prefskylo: widget.prefskylo,
        )));

  }
}
