import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:politician/POLITICIAN/utils/appId.dart';
import 'package:politician/Users/Bottomnavigation/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BroadcastPage extends StatefulWidget {
  final String channelName;
  final bool isBroadcaster;
  SharedPreferences prefskylo;

  BroadcastPage({required this.channelName,required this.isBroadcaster, required this.prefskylo});

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  late DatabaseReference ref,ref1;
  final _users = <int>[];
  final _infoStrings = <String>[];
  late RtcEngine _engine;
  bool muted = false;
  late String message;
  late int position;
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

    ref = FirebaseDatabase.instance.reference().child("Kylochats");
    ref1 = FirebaseDatabase.instance.reference().child("Kylousers");
    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    print('Client Role: ${widget.isBroadcaster}');
    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.joinChannel(Token,widget.channelName, null, 1234);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      await _engine.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine.setClientRole(ClientRole.Audience);
    }
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  Widget noofusers() {
    return Padding(
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
                      SizedBox(height: 10,),
                      Text("${item.length} Users Watching",style: TextStyle(fontSize: 25,color: Colors.white),),
                      SizedBox(height: 10,),
                      Container(
                        height: 170,
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
                              title: Text(item[index]["User"],style: TextStyle(color: Colors.white),),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              else{
                return Text(" ");
              }
            }
        ),
      ),
    );
  }

  Widget _toolbar() {
    return widget.isBroadcaster
        ? Text("SSP",style: TextStyle(fontSize: 40,color: Colors.red),)
        : Container(
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
                        return ListView.builder(
                          itemCount: item.length,
                          itemBuilder: (context,index){
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                child: Text("P",style: TextStyle(fontSize: 25,color: Colors.white),),
                              ),
                              title: Text(item[index]["Title"],style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),),
                              subtitle: Text(item[index]["Message"],style: TextStyle(color: Colors.white),),
                            );
                          },
                        );
                      }
                      else{
                        return Text("");
                      }
                    }
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {

                },
                child: Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                  size: 30.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.deepOrangeAccent,
                padding: const EdgeInsets.all(15.0),
              ),
              SizedBox(width: 10),
              RawMaterialButton(
                onPressed: () {
                  _onCallEnd(context);
                },
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
          SizedBox(height: 15),
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
              GestureDetector(
                onTap: (){
                  print("_____________________________________________________________________");
                  Map data = <String, dynamic>{
                    "Title": FirebaseAuth.instance.currentUser == null
                        ? "Anonymous User"
                        : FirebaseAuth.instance.currentUser!.displayName==null
                        ? "User Signed With Phone Number"
                        : FirebaseAuth.instance.currentUser!.displayName,
                    "Message": message,
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: <Widget>[
              _viewRows(),
              noofusers(),
              _toolbar(),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if(widget.isBroadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    print(views);
    print("-------------------------------------------------");
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
              children: <Widget>[_videoView(views[0])],
            ));
      case 2:
        return Container(
            child: Column(
              children: <Widget>[
                _expandedVideoRow([views[0]]),
                _expandedVideoRow([views[1]])
              ],
            ));
      case 3:
        return Container(
            child: Column(
              children: <Widget>[
                _expandedVideoRow(views.sublist(0, 2)),
                _expandedVideoRow(views.sublist(2, 3))
              ],
            ));
      case 4:
        return Container(
            child: Column(
              children: <Widget>[
                _expandedVideoRow(views.sublist(0, 2)),
                _expandedVideoRow(views.sublist(2, 4))
              ],
            ));
      default:
    }
    return Container();
  }

  void _onCallEnd(BuildContext context) {
    ref1.remove();
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
    _engine.switchCamera();
  }

}