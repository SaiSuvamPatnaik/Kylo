import 'package:flutter/material.dart';
import 'package:politician/POLITICIAN/Services/twitter.dart';

Widget tweets(BuildContext context){
  return Container(
    color: Color(0xFFe5e5e5),
    height: 406,
    width: MediaQuery.of(context).size.width,
    child: FutureBuilder(
        future: Twittercall(),
        builder: (context,AsyncSnapshot snap){
          if (snap.hasData) {
            var tweets = snap.data;
            return ListView.builder(
              itemCount: tweets.length,
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
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Image.network(
                                "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png",
                                  height: 50.0,
                                  width: 50.0,
                                ),
                              ),
                              SizedBox(width: 20,),
                              Text("Mr XYZ",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),),

                            ],
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10,0,0,0),
                            child: Text(tweets[index].fullText,
                              textScaleFactor: 1,
                              maxLines: 20,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10,0,0,0),
                            child: Text(tweets[index].createdAt.toString().substring(0,10),
                              textScaleFactor: 1,
                              style: TextStyle(color: Color(0xff687684),fontSize: 16,fontFamily: 'Montserrat',fontWeight: FontWeight.w400),),
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10,0,0,0),
                            child: Text("${tweets[index].favoriteCount.toString()} Likes  ${tweets[index].retweetCount.toString()} Retweets",
                              textScaleFactor: 1,
                              style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'Montserrat'),),
                          ),
                          SizedBox(height: 15,),

                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          else{
            return Center(
                child: CircularProgressIndicator());
          }
        }
    ),
  );
}