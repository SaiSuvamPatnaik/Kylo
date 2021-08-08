import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:politician/POLITICIAN/utils/appId.dart';
import 'package:politician/Users/Bottomnavigation/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BroadcastPage extends StatefulWidget {
  final String channelName,token;
  final bool isBroadcaster;
  SharedPreferences prefskylo;
  BroadcastPage({required this.token,required this.channelName, required this.isBroadcaster,required this.prefskylo});

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  final _users = <int>[];
  late RtcEngine _engine;
  bool muted = false;
  late int streamId;
  late DatabaseReference ref,ref1,ref2;
  late String message;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk and leave channel
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initializeAgora();
    ref = FirebaseDatabase.instance.reference().child("Kylochats");
    ref1 = FirebaseDatabase.instance.reference().child("Kylousers");
    ref2 = FirebaseDatabase.instance.reference().child("Kylotrial");
  }

  Future<void> initializeAgora() async {
    await _initAgoraRtcEngine();

    if (widget.isBroadcaster) streamId = (await _engine.createDataStream(false, false))!;

    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          print('onJoinChannel: $channel, uid: $uid');
        });
      },
      leaveChannel: (stats) {
        setState(() {
          print('onLeaveChannel');
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          print('userJoined: $uid');

          _users.add(uid);
        });
      },
      userOffline: (uid, elapsed) {
        setState(() {
          print('userOffline: $uid');
          _users.remove(uid);
        });
      },
      streamMessage: (_, __, message) {
        final String info = "here is the message $message";
        print(info);
      },
      streamMessageError: (_, __, error, ___, ____) {
        final String info = "here is the error $error";
        print(info);
      },
    ));

    await _engine.joinChannel(widget.token,
        "abc", null,0);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(appId));
    await _engine.enableVideo();

    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      await _engine.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine.setClientRole(ClientRole.Audience);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _broadcastView(),
            noofusers(context),
            _toolbar(),
          ],
        ),
      ),
    );
  }


  Widget noofusers(BuildContext Context) {
    return widget.isBroadcaster==false
        ? Padding(
      padding: const EdgeInsets.fromLTRB(141,0,0,0),
      child: Container(
        height: 230,
        width:  250,
        alignment: Alignment.topRight,
        child: StreamBuilder(
            stream: ref1.onValue,
            builder: (context,AsyncSnapshot snap){
              if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
                Map data = snap.data.snapshot.value;
                List item = [];

                data.forEach((index, data) => item.add({"key": index, ...data}));

                return Container(
                  color: Colors.black26,
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Text("${item.length} Users Watching",
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: 25,color: Colors.white),),
                      SizedBox(height: 10,),
                      Container(
                        height: 130,
                        child: ListView.builder(
                          itemCount: item.length,
                          itemBuilder: (context,index){
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                child: ClipOval(
                                  child: Image.network(item[index]["Photo"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(item[index]["User"],
                                textScaleFactor: 1,
                                style: TextStyle(color: Colors.white),),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              else{
                return Text(" ",textScaleFactor: 1,);
              }
            }
        ),
      ),
    ) :  Text("SSP",textScaleFactor: 1,);
  }


  Widget _toolbar() {
    return widget.isBroadcaster==false
        ? Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                    stream: ref.onValue,
                    builder: (context,AsyncSnapshot snap){
                      if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
                        Map data = snap.data.snapshot.value;
                        List item = [];
                        data.forEach((index, data) => item.add({"key": index, ...data}));
                        item.sort((a, b) => a["Date"].compareTo(b["Date"]));
                        return ListView.builder(
                          itemCount: item.length,
                          itemBuilder: (context,index){
                            return ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  child: Image.network("https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png")
                              ),
                              title: Text(item[index]["Title"],
                                textScaleFactor: 1,
                                style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),),
                              subtitle: Text(item[index]["Message"],
                                textScaleFactor: 1,
                                style: TextStyle(color: Colors.white),),
                            );
                          },
                        );
                      }
                      else{
                        return Text("",textScaleFactor: 1,);
                      }
                    }
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width-100,
                child: TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    hintText: 'Type Text Here...',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (value){
                    message=value;
                  },
                ),
              ),
              SizedBox(width: 15,),
              GestureDetector(
                onTap: (){
                  String datetime = DateTime.now().toString();
                  Map data = <String, dynamic>{
                    "Title": FirebaseAuth.instance.currentUser == null
                        ? "Anonymous User"
                        : FirebaseAuth.instance.currentUser!.displayName==null
                        ? "User Signed With Phone Number"
                        : FirebaseAuth.instance.currentUser!.displayName,
                    "Message": message,
                    "Date":datetime
                  };
                  ref.push().set(data);
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.send,color: Colors.white,),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: _onToggleMute,
                  child: Icon(
                    Icons.card_giftcard,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.deepOrange,
                  padding: const EdgeInsets.fromLTRB(0,12,0,12),
                ),
                RawMaterialButton(
                  onPressed: () => _onCallEnd(context,ref1),
                  child: Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.redAccent,
                  padding: const EdgeInsets.all(15.0),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        : Container(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,30,20,0),
          child: GestureDetector(
            onTap: (){
              ref1.remove();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Navigation(prefskylo:widget.prefskylo,tweetpressed: false)));
            },
            child: CircleAvatar(
              radius: 30,
              child: Icon(Icons.arrow_back,size: 30,),
            ),
          ),
        )
    );
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.isBroadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view row wrapper
  Widget _expandedVideoView(List<Widget> views) {
    final wrappedViews = views.map<Widget>((view) => Expanded(child: Container(child: view))).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _broadcastView() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
              children: <Widget>[
                _expandedVideoView([views[0]])
              ],
            ));
      case 2:
        return Container(
            child: Column(
              children: <Widget>[
                _expandedVideoView([views[0]]),
                _expandedVideoView([views[1]])
              ],
            ));
      case 3:
        return Container(
            child: Column(
              children: <Widget>[_expandedVideoView(views.sublist(0, 2)), _expandedVideoView(views.sublist(2, 3))],
            ));
      case 4:
        return Container(
            child: Column(
              children: <Widget>[_expandedVideoView(views.sublist(0, 2)), _expandedVideoView(views.sublist(2, 4))],
            ));
      default:
    }
    return Container();
  }

  void _onCallEnd(BuildContext context, DatabaseReference ref1) {
    _engine.disableVideo();
    ref1.once().then((DataSnapshot snapshot) {
      Map removedata = snapshot.value;
      removedata.entries.forEach((element)
      {
        var currentuserwantstodelete =
        FirebaseAuth.instance.currentUser == null
            ? "Anonymous User"
            : FirebaseAuth.instance.currentUser!.displayName==null
            ? "User Signed With Phone Number"
            : FirebaseAuth.instance.currentUser!.displayName;

        if (element.value["User"]==currentuserwantstodelete){
          print(element.key);
          ref1.child(element.key).remove();
        }
      });
    });

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Navigation(prefskylo:widget.prefskylo,tweetpressed: false)));
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    if (streamId != null){
      _engine.switchCamera();
    }
  }
}
