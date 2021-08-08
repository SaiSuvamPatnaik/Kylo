import 'package:flutter/material.dart';
import 'package:flutter_login_video/Screens/Home/SpellRoom/Spellstart.dart';

class Spellroomfirst extends StatefulWidget {
  @override
  _SpellroomfirstState createState() => _SpellroomfirstState();
}

class _SpellroomfirstState extends State<Spellroomfirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
            image: AssetImage('Assets/Images/Pot-room-new 3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Spellstart()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width-50,
              height: 60,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcOver),
                    image: AssetImage('Assets/Images/Button_large1 1.png'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 2,
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(10) // use instead of BorderRadius.all(Radius.circular(20))
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,12,0,12),
                  child: Text("Begin Your Spell",
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
        ),
      ),
    );
  }
}
