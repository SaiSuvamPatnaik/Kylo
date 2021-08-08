import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:politician/Splash/splash.dart';
import 'package:politician/Users/Screens/Homepage/UserProfile/EditProfile.dart';
import 'package:politician/Users/Services/GoogleSignInApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profile extends StatefulWidget {
  SharedPreferences prefskylo;
  profile({required this.prefskylo});
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30,60,0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your Profile",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    FirebaseAuth.instance.currentUser!=null
                        ? GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => EditProfile(prefskylo: widget.prefskylo)));
                            },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,20,0),
                            child: Row(
                              children: [
                                Icon(Icons.edit,size: 18,color: Colors.black,),
                                SizedBox(width: 5,),
                                Text("Edit ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                          ],
                        ),
                      ),
                    )
                        : Text("")
                  ],
                ),
                SizedBox(height: 50,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png",
                    height: 110.0,
                    width: 110.0,
                  ),
                ),
                SizedBox(height: 30,),
                FirebaseAuth.instance.currentUser==null
                    ? profilesdisplay("Full Name", "Anonymous User")
                    : profilesdisplay(
                    "Full Name" ,
                    widget.prefskylo.containsKey("Name"+FirebaseAuth.instance.currentUser!.uid)==false
                        ? FirebaseAuth.instance.currentUser==null
                          ? "Anonymous User"
                          : FirebaseAuth.instance.currentUser!.displayName!=null
                            ? FirebaseAuth.instance.currentUser!.displayName.toString()
                            : "Anonymous User"
                        : widget.prefskylo.getString("Name"+FirebaseAuth.instance.currentUser!.uid)
                ),
                FirebaseAuth.instance.currentUser==null
                    ? profilesdisplay("Email Id", "user@gmail.com")
                    : profilesdisplay("Email Id" ,
                    widget.prefskylo.containsKey("Email"+FirebaseAuth.instance.currentUser!.uid)==false
                        ? FirebaseAuth.instance.currentUser==null
                          ? "user@gmail.com"
                          : FirebaseAuth.instance.currentUser!.email!=null
                            ? FirebaseAuth.instance.currentUser!.email.toString()
                            : "Email Address Not Provided"
                        : widget.prefskylo.getString("Email"+FirebaseAuth.instance.currentUser!.uid)
                ),
                FirebaseAuth.instance.currentUser==null
                    ? profilesdisplay("Phone Number", "+91-XXXXXXXXXX")
                    : profilesdisplay("Phone Number",
                    widget.prefskylo.containsKey("Phone"+FirebaseAuth.instance.currentUser!.uid)==false
                        ? FirebaseAuth.instance.currentUser==null
                          ? "Phone Number Not Provided"
                          : FirebaseAuth.instance.currentUser!.phoneNumber!=null
                            ? FirebaseAuth.instance.currentUser!.phoneNumber.toString()
                            : "Phone Number Not Provided"
                        : widget.prefskylo.getString("Phone"+FirebaseAuth.instance.currentUser!.uid)
                ),


                GestureDetector(
                  onTap: (){
                    FirebaseService().signOutFromGoogle();
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => splash()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width-50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFD011),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                        child: Text("Log Out",
                          textScaleFactor: 1
                          ,style: TextStyle(color: Color(0xFF6C6C6C),fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.w700),)),
                  ),
                ),
                SizedBox(height: 35,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

Widget profilesdisplay(String text1, String? text2){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(text1,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300
        ),
      ),
      SizedBox(height: 8,),
      Padding(
        padding: const EdgeInsets.fromLTRB(0,0,40,0),
        child: TextField(
          focusNode: AlwaysDisabledFocusNode(),
          decoration: InputDecoration(
            hintText: text2,
            hintStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
            fillColor: Color(0xfff3f3f3),
          ),
        ),
      ),
      SizedBox(height: 25,)
    ],
  );
}


//Navigator.push(
//context,
//MaterialPageRoute(builder: (context) => Navigation(prefskylo:prefskylo)));