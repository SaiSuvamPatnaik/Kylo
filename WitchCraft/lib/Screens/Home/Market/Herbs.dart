import 'package:flutter/material.dart';
import 'package:flutter_login_video/Screens/Home/Market/Crystal.dart';

class Herbs extends StatefulWidget {
  @override
  _HerbsState createState() => _HerbsState();
}

class _HerbsState extends State<Herbs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/Images/Ingredients_002 1.png'),
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
                  Text("Herbs",
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
                          MaterialPageRoute(builder: (context) => Crystal()));
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
