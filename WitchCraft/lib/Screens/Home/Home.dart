import 'package:flutter/material.dart';
import 'package:flutter_login_video/Screens/Home/Library/Library.dart';
import 'package:flutter_login_video/Screens/Home/Market/Market.dart';
import 'package:flutter_login_video/Screens/Home/SpellRoom/Spellroomfirst.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcOver),
            image: AssetImage('Assets/Images/loginpage.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,60,0,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,0,0),
                  child: CircleAvatar(
                    radius: 40,
                    child: Text("Back",
                      style: TextStyle(
                          fontFamily: 'Cardinal',
                          fontSize: 26,
                          decoration: TextDecoration.none,
                          color: Colors.white
                      ),
                    ),
                    backgroundImage: AssetImage("Assets/Images/Button_large1 1.png"),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height-190,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,15,0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Library()));
                          },
                          child: Container(
                            width: 130,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcOver),
                                  image: AssetImage('Assets/Images/Button_large1 1.png'),
                                  fit: BoxFit.cover,
                                ), // use instead of BorderRadius.all(Radius.circular(20))
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0,12,0,12),
                                child: Text("Library",
                                  style: TextStyle(
                                      fontFamily: 'Cardinal',
                                      fontSize: 26,
                                      decoration: TextDecoration.none,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 70,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Market()));
                              },
                              child: Container(
                                width: 130,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcOver),
                                    image: AssetImage('Assets/Images/Button_large1 1.png'),
                                    fit: BoxFit.cover,
                                  ), // use instead of BorderRadius.all(Radius.circular(20))
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0,12,0,12),
                                    child: Text("Market",
                                      style: TextStyle(
                                          fontFamily: 'Cardinal',
                                          fontSize: 26,
                                          decoration: TextDecoration.none,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Spellroomfirst()));
                              },
                              child: Container(
                                width: 130,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcOver),
                                    image: AssetImage('Assets/Images/Button_large1 1.png'),
                                    fit: BoxFit.cover,
                                  ), // use instead of BorderRadius.all(Radius.circular(20))
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0,12,0,12),
                                    child: Text("Spell Room",
                                      style: TextStyle(
                                          fontFamily: 'Cardinal',
                                          fontSize: 26,
                                          decoration: TextDecoration.none,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
