import 'package:flutter/material.dart';
import 'package:flutter_login_video/Screens/Home/Market/Flowers.dart';

class Crystal extends StatefulWidget {
  @override
  _CrystalState createState() => _CrystalState();
}

class _CrystalState extends State<Crystal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/Images/Ingredients_003 1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10,60,10,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      child: Text("Back",
                        style: TextStyle(
                            fontFamily: 'Cardinal',
                            fontSize: 20,
                            decoration: TextDecoration.none,
                            color: Colors.white
                        ),
                      ),
                      backgroundImage: AssetImage("Assets/Images/Button_large1 1.png"),
                    ),
                  ),
                  Text("Crystals",
                    style: TextStyle(
                        fontFamily: 'Cardinal',
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Color(0xffFEB53C)
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Flowers()));
                    },
                    child: CircleAvatar(
                      radius: 30,
                      child: Text("Next",
                        style: TextStyle(
                            fontFamily: 'Cardinal',
                            fontSize: 20,
                            decoration: TextDecoration.none,
                            color: Colors.white
                        ),
                      ),
                      backgroundImage: AssetImage("Assets/Images/Button_large1 1.png"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
