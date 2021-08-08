import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Schedule_Event extends StatefulWidget {
  @override
  _Schedule_EventState createState() => _Schedule_EventState();
}

class _Schedule_EventState extends State<Schedule_Event> {
  late TextEditingController event,eventdate,eventtime;
  DateTime selectedDate = DateTime.now();
  late DatabaseReference ref4;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref4 = FirebaseDatabase.instance.reference().child("Kyloevents");
    event = new TextEditingController();
    eventdate = new TextEditingController();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        eventdate.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,0,0,0),
            child: Text("Schedule Event",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600
              ),),
          ),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-110,
            color: Color(0xffF2F4F6),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,30,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Text("What is the Event ??",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,20,20,0),
                    child: TextField(
                      controller: event,
                      decoration: InputDecoration(
                        hintText: 'Describe the event',
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
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 10,),
                      Text("Event Date",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,20,20,0),
                    child: TextField(
                      focusNode: AlwaysDisabledFocusNode(),
                      controller: eventdate,
                      decoration: InputDecoration(
                        hintText: 'Select Date',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today,size: 25,),
                          onPressed: (){
                            _selectDate(context);
                          },
                        ),
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
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 60,),
                  GestureDetector(
                    onTap: (){
                      Map eventdata = {
                        "Event":event.text,
                        "Date":eventdate.text,
                        "Postedtime":DateTime.now().toString()
                      };
                      ref4.push().set(eventdata).then((value) => print("PUSHED"));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width-50,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Color(0xFFFFD011),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(
                          child: Text("Schedule",
                            textScaleFactor: 1
                            ,style: TextStyle(color: Color(0xFF6C6C6C),fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.w700),)),
                    ),
                  ),



                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}