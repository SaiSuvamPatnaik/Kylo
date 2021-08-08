import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcOver),
            image: AssetImage('Assets/Images/library_bg 1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20,60,0,0),
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
                  Text("Library",
                    style: TextStyle(
                        fontFamily: 'Cardinal',
                        fontSize: 32,
                        decoration: TextDecoration.none,
                        color: Colors.white
                    ),
                  ),
                  Text("        ",
                    style: TextStyle(
                        fontFamily: 'Cardinal',
                        fontSize: 26,
                        decoration: TextDecoration.none,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,0,40,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("Assets/Images/Normal01 1.png",scale: 2.3,),
                  Image.asset("Assets/Images/Normal1 1.png",scale: 2.3,),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,0,40,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("Assets/Images/Lock_3.png",scale: 2.3,),
                  Image.asset("Assets/Images/Lock_3.png",scale: 2.3,),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,0,40,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("Assets/Images/Lock_3.png",scale: 2.3,),
                  Image.asset("Assets/Images/Lock_3.png",scale: 2.3,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
