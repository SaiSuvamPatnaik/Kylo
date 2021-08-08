import 'package:flutter/material.dart';
import 'package:politician/POLITICIAN/Bottomnavigation/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signin extends StatefulWidget {
  SharedPreferences prefskylo;
  signin({required this.prefskylo});
  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
  late String username,password;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Color(0xff6c6c6c).withOpacity(0.6),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20,20,20,20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text("Svāgatam!",
                    textScaleFactor: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500)),
                    const Text("Log in",
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,30,20,0),
                      child: TextField(
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          fillColor: Colors.white,
                        ),
                        onChanged: (value1){
                          username=value1;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,30,20,0),
                      child: TextField(
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        style: TextStyle(fontSize: 18,),
                        decoration: InputDecoration(
                          hintText:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            'Enter Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          fillColor: Colors.white,
                        ),
                        onChanged: (value2){
                          password=value2;
                        },
                      ),
                    ),
                    SizedBox(height: 50,),
                    GestureDetector(
                      onTap: (){
                        if (username=="admin" && password=="admin"){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Navigation(prefskylo:widget.prefskylo,tweetpressed: false,)));
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width-50,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color(0xFFFFD011),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: const Center(
                            child: Text("Sign In",
                                textScaleFactor: 1
                              ,style: TextStyle(color: Color(0xFF6C6C6C),fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.w700),)),
                      ),
                    ),
                    SizedBox(height: 20,),


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
