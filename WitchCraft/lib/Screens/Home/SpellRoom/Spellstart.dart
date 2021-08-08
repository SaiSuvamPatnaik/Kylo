import 'package:flutter/material.dart';

class Spellstart extends StatefulWidget {
  @override
  _SpellstartState createState() => _SpellstartState();
}

class _SpellstartState extends State<Spellstart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/Images/Pot-room-new 3.png'),
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}
