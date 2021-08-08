import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:politician/Users/Bottomnavigation/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  SharedPreferences prefskylo;
  EditProfile({required this.prefskylo});
  @override
  _EditProfileState createState() => _EditProfileState(prefskylo:prefskylo);
}

class _EditProfileState extends State<EditProfile> {
  late String name,email,phone;
  SharedPreferences prefskylo;
  _EditProfileState({required this.prefskylo});
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
                    Text("Edit Your Profile",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png",
                    height: 110.0,
                    width: 110.0,
                  ),
                ),
                SizedBox(height: 30,),
                Text("Your Full Name",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300
                  ),
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,40,0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Name",
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
                    onChanged: (value1){
                      prefskylo.setString("Name"+FirebaseAuth.instance.currentUser!.uid.toString(), value1);
                      setState(() {
                        name=value1;
                      });
                    },
                  ),
                ),
                SizedBox(height: 25,),
                Text("Email Address",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300
                  ),
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,40,0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Email Id",
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
                    onChanged: (value2){
                      prefskylo.setString("Email"+FirebaseAuth.instance.currentUser!.uid.toString(), value2);
                      setState(() {
                        email=value2;
                      });
                    },
                  ),
                ),
                SizedBox(height: 25,),
                Text("Phone Number",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300
                  ),
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,40,0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Phone",
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
                    onChanged: (value3){
                      prefskylo.setString("Phone"+FirebaseAuth.instance.currentUser!.uid.toString(), value3);
                      setState(() {
                        phone=value3;
                      });
                    },
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Navigation(prefskylo: prefskylo,tweetpressed: false)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width-50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFD011),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                        child: Text("Save Changes",
                          textScaleFactor: 1
                          ,style: TextStyle(color: Color(0xFF6C6C6C),fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.w700),)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
