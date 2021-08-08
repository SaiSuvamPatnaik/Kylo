import 'package:flutter/material.dart';
import 'package:flutter_login_video/Screens/Home/Home.dart';

class phoneotp extends StatefulWidget {
  @override
  _phoneotpState createState() => _phoneotpState();
}

class _phoneotpState extends State<phoneotp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Text("Enter the code we just send you on the mobile number",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Cardinal',
                  fontSize: 35,
                  decoration: TextDecoration.none,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 35,),
            Container(
              width: MediaQuery.of(context).size.width-50,
              height: 60,
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,0,0,0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      fontFamily: 'Cardinal',
                      fontSize: 30,
                      decoration: TextDecoration.none,
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover,
                  image: AssetImage("Assets/Images/Text_box 6.png",),
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
      ),
    );
  }
}
