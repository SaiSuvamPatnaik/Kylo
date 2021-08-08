import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:politician/Users/Bottomnavigation/Navigation.dart';
import 'package:politician/Users/Screens/Authentication/signinusingphone.dart';
import 'package:politician/Users/Services/GoogleSignInApi.dart';
import 'package:shared_preferences/shared_preferences.dart';


class signinuser extends StatefulWidget {
  SharedPreferences prefskylo;
  signinuser({required this.prefskylo});
  @override
  _signinuserState createState() => _signinuserState();
}

class _signinuserState extends State<signinuser> {

  TextEditingController controller1= new TextEditingController();
  TextEditingController controller2= new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller1.text="user@gmail.com";
    controller2.text="user";
  }
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
              color: Color(0xff6c6c6c).withOpacity(0.7),
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
                        controller: controller1,
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

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,30,20,0),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: controller2,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'Enter Passwoed',
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
                      ),
                    ),
                    SizedBox(height: 50,),
                    GestureDetector(
                      onTap: (){
                        if (controller1.text=="user@gmail.com" && controller2.text=="user"){
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
                              ,style: TextStyle(
                                  color: Color(0xFF6C6C6C),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        // ignore: prefer_const_literals_to_create_immutables
                        Expanded(child: Divider(color:Colors.white,thickness: 2,)),
                        // ignore: prefer_const_literals_to_create_immutables
                        const Text(" Or Sign In Using ",
                            textScaleFactor: 1,
                            // ignore: prefer_const_literals_to_create_immutables
                            style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w300)),
                        Expanded(child: Divider(color:Colors.white,thickness: 2,)),
                      ],
                    ),
                    SizedBox(height: 10,),
                    TextButton(
                      onPressed: () async {
                        FirebaseService service = new FirebaseService();
                        await service.signInwithGoogle();
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Navigation(prefskylo:widget.prefskylo,tweetpressed: false)));
                      },
                      child: Container(
                        // padding: EdgeInsets.all(7.5),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8.0),
                                child:
                                Image.asset("Assets/Images/Google__G__Logo.png"),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.55,
                              alignment: Alignment.center,
                              child: const Text(
                                "SignUp with Google",
                                  textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 15.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (FirebaseAuth.instance.currentUser==null){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => signinusingphone(prefskylo:widget.prefskylo)));
                        }
                        else{
                          print(FirebaseAuth.instance.currentUser);
                          if (FirebaseAuth.instance.currentUser!.displayName!=null){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ALREADY SIGNED IN USING GOOGLE.",textScaleFactor: 1)));
                          }
                          if (FirebaseAuth.instance.currentUser!.displayName==null){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Navigation(prefskylo:widget.prefskylo,tweetpressed: false)));
                          }
                        }
                      },
                      child: Container(
                        // padding: EdgeInsets.all(7.5),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8.0),
                                child:
                                Image.asset("Assets/Images/helpAndSupport.png"),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.55,
                              alignment: Alignment.center,
                              child: Text(
                                "Continue with Phone",
                                  textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 15.0),
                            ),
                          ],
                        ),
                      ),
                    ),

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
