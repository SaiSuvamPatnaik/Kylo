import 'package:flutter/material.dart';
import 'package:flutter_login_video/Screens/Authentication/phonesignin.dart';
import 'package:flutter_login_video/Screens/Home/Home.dart';


class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcOver),
          image: AssetImage('Assets/Images/Signin.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome To",
            style: TextStyle(
                fontFamily: 'Cardinal',
                fontSize: 40,
                decoration: TextDecoration.none,
                color: Colors.white
            ),
          ),
          Text("Witchcraft",
            style: TextStyle(
                fontFamily: 'Cardinal',
                fontSize: 60,
                decoration: TextDecoration.none,
                color: Color(0xffFEB53C)
            ),
          ),
          SizedBox(height: 35,),
          Text("Sign In To Continue ",
            style: TextStyle(
                fontFamily: 'Cardinal',
                fontSize: 40,
                decoration: TextDecoration.none,
                color: Colors.white
            ),
          ),
          SizedBox(height: 35,),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => phonesignin()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width-50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcOver),
                    image: AssetImage('Assets/Images/Text_box 6.png'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 2,
                    color: Color(0xffFEB53C),
                  ),
                  borderRadius: BorderRadius.circular(10) // use instead of BorderRadius.all(Radius.circular(20))
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,12,0,12),
                  child: Text("Enter Mobile Number",
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
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width-50,
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
                  child: Text("Continue",
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
          )
        ],
      ),
    );
  }
}
