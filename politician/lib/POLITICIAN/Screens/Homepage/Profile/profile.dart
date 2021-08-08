import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30,60,0,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your Profile",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 50,),
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png",
                  height: 110.0,
                  width: 110.0,
                ),
              ),
              SizedBox(height: 30,),
              Text("Your Full Name",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,40,0),
                child: TextField(
                  focusNode: AlwaysDisabledFocusNode(),
                  decoration: InputDecoration(
                    hintText: 'Mr XYZ',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    fillColor: Color(0xfff3f3f3),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Text("Gender",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,40,0),
                child: TextField(
                  focusNode: AlwaysDisabledFocusNode(),
                  decoration: InputDecoration(
                    hintText: 'Male',
                    hintStyle: TextStyle(fontSize: 16),
                    suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    fillColor: Color(0xfff3f3f3),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Text("Email Address",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,40,0),
                child: TextField(
                  focusNode: AlwaysDisabledFocusNode(),
                  decoration: InputDecoration(
                    hintText: 'contact@nationalparty.org',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    fillColor: Color(0xfff3f3f3),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Text("Phone Number",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,40,0),
                child: TextField(
                  focusNode: AlwaysDisabledFocusNode(),
                  decoration: InputDecoration(
                    hintText: '+9194XXXXXXXX',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    fillColor: Color(0xfff3f3f3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}