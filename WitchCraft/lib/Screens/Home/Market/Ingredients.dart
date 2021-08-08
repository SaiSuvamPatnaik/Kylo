import 'package:flutter/material.dart';
import 'package:flutter_login_video/Screens/Home/Market/Herbs.dart';

class Ingredients extends StatefulWidget {
  @override
  _IngredientsState createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapUp: (TapUpDetails details) => _onTapUp(details),
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/Images/Ingredients_001 2.png'),
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
                    Text("OILS",
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
                            MaterialPageRoute(builder: (context) => Herbs()));
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
      ),
    );
  }

  _onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    print(details.localPosition);
    print("tap up " + x.toString() + ", " + y.toString());
    if ( (x>90.0 && x<130) && (y>200.0 && y<240.0)){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text("8 Surprising Health Benefits of Cloves",
              textAlign: TextAlign.center,
              textScaleFactor: 1,
              style: TextStyle(
                  fontFamily: 'Cardinal',
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  color: Color(0xffFEB53C)
            ),
          ),
          content: Text("Contain important nutrients. High in antioxidants. May help protect against cancer. Can kill bacteria. May improve liver health. May help regulate blood sugar. May promote bone health. May reduce stomach ulcers.",
            textAlign: TextAlign.center,
            textScaleFactor: 1,
            style: TextStyle(
                fontFamily: 'Cardinal',
                fontSize: 26,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,

            ),
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: GestureDetector(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: Text("OK",textScaleFactor: 1,style: TextStyle(fontSize: 18),)),
            )
          ],
        );
      });
    }
  }
}
