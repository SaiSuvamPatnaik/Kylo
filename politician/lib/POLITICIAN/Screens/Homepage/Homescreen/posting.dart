import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget posts(BuildContext context, DatabaseReference ref3, SharedPreferences prefskylo){
  return Container(
    color: Color(0xFFe5e5e5),
    height: 406,
    width: MediaQuery.of(context).size.width,
    child: StreamBuilder(
        stream: ref3.orderByKey().onValue,
        builder: (context,AsyncSnapshot snap){
          if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
            Map data = snap.data.snapshot.value;
            List item = [];
            data.forEach((index, data)
            {
              item.add({"key":index, ...data});
            }
            );
            item.sort((a, b) => a["Date"].compareTo(b["Date"]));
            return ListView.builder(
              itemCount: item.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,10),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15,20,15,15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.network(
                                      "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png",
                                      height: 40.0,
                                      width: 40.0,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("Mr XYZ",
                                    textScaleFactor: 1,
                                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),),
                                ],
                              ),
                              GestureDetector(
                                  onTap: (){
                                    showDialog(context: context, builder: (context){
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        title: Text("Delete Message",textScaleFactor: 1),
                                        content: Text("Do You Really Want To Delete This Post ??",style: TextStyle(fontSize: 18),),
                                        actions: [
                                          Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                    onTap:(){
                                                      ref3.child(item[index]["key"]).remove().then((value) =>
                                                          Navigator.pop(context));
                                                    },
                                                    child: Text("Yes",textScaleFactor: 1,style: TextStyle(fontSize: 18),)),
                                                SizedBox(width: 20,),
                                                GestureDetector(
                                                    onTap:(){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("No",textScaleFactor: 1,style: TextStyle(fontSize: 18),)),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    });
                                  },
                                  child: Icon(Icons.delete))
                            ],
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10,0,0,0),
                            child: Text(item[index]["Message"],
                              textScaleFactor: 1,
                              maxLines: 20,
                              style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),),
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10,0,0,0),
                            child: Text(item[index]["Date"].toString().substring(0,10),
                              textScaleFactor: 1,
                              style: TextStyle(color: Color(0xff687684),fontSize: 16,fontWeight: FontWeight.w400),),
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10,0,0,0),
                            child: Text("${item[index]["Like"]} Likes  ${item[index]["Dislike"]} Dislikes",
                              textScaleFactor: 1,
                              style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),),
                          ),
                          SizedBox(height: 15,),
                          Divider(
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: (){
                                    var alreadyliked = prefskylo.getBool("postliked${item[index]["key"]}")??false;
                                    if (alreadyliked==false){
                                      prefskylo.setBool("postliked${item[index]["key"]}",true);
                                      ref3.child(item[index]["key"]).update({
                                        'Like' : item[index]["Like"]+1
                                      });
                                    }
                                    else {
                                      prefskylo.setBool("postliked${item[index]["key"]}",false);
                                      ref3.child(item[index]["key"]).update({
                                        'Like' : item[index]["Like"]-1
                                      });
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.thumb_up_sharp,size: 20,color: getcolorlikes(prefskylo, index, item),),
                                      SizedBox(width: 6,),
                                      Container(
                                        child: Center(
                                            child: Text("Like",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: getcolorlikes(prefskylo,index,item),
                                                  fontWeight: FontWeight.w600),)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(height: 30, child: VerticalDivider(thickness:2,color: Colors.blueAccent)),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: (){
                                    var alreadydisliked = prefskylo.getBool("postdisliked${item[index]["key"]}")??false;
                                    if (alreadydisliked==false){
                                      prefskylo.setBool("postdisliked${item[index]["key"]}",true);
                                      ref3.child(item[index]["key"]).update({
                                        'Dislike' : item[index]["Dislike"]+1
                                      });
                                    }
                                    else {
                                      prefskylo.setBool("postdisliked${item[index]["key"]}",false);
                                      ref3.child(item[index]["key"]).update({
                                        'Dislike' : item[index]["Dislike"]-1
                                      });
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.thumb_down,size: 20,color: getcolordislikes(prefskylo, index, item),),
                                      SizedBox(width: 6,),
                                      Container(
                                        child: Center(
                                            child: Text("Dislike",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: getcolordislikes(prefskylo, index, item),
                                                  fontWeight: FontWeight.w600),)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          else{
            return Center(child: Text("No Messages To Show",
              textScaleFactor: 1,
              style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),));
          }
        }
    ),
  );
}

getcolordislikes(SharedPreferences prefskylo, int index, List item) {

  if (prefskylo.getBool("postdisliked${item[index]["key"]}")==true){
    return Colors.red;
  }
  else {
    return Colors.black;
  }
}

getcolorlikes(SharedPreferences prefskylo, int index, List item) {

  if (prefskylo.getBool("postliked${item[index]["key"]}")==true){
    return Colors.blue;
  }
  else {
    return Colors.black;
  }
}
