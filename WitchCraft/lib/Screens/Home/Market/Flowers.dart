import 'package:flutter/material.dart';

class Flowers extends StatefulWidget {
  @override
  _FlowersState createState() => _FlowersState();
}

class _FlowersState extends State<Flowers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/Images/Ingredients_004 1.png'),
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
                  Text("Flowers",
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
