import 'package:flutter/material.dart';
import 'package:flutter_login_video/Screens/Home/Market/Ingredients.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/Images/markect_place 2.png'),
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
                  Text("Witch Market",
                    style: TextStyle(
                        fontFamily: 'Cardinal',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Color(0xffFEB53C)
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Ingredients()));
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
