import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List Detailsdata = [
    {
      "Text1":"About National Party",
      "Text2":"National Party is a party, which has a strong presence both at state level and central politcis. National Party was formed by Mr XYZ. National Party espoused no specific ideology except for its commitment of safeguarding “the political, economic, social, and cultural foundations of Telugu-speaking people.” TDP was the first regional party in independent India to have formed the main opposition in the 8th Lok Sabha (1984). Currently, TDP holds 17 Lok Sabha Seats.",
      "Url":"https://en.wikipedia.org/wiki/List_of_political_parties_in_India",
      "Image":"Assets/Images/Details1.png"
    },
    {
      "Text1":"Achievements",
      "Text2":"The National Party has helped all-round development of the farmers by providing them loans at minimal interest; electrification of the rural areas; and providing cheap water facilities and maximum technological innovation to enhance the agricultural economy in the state.",
      "Url":"https://en.wikipedia.org/wiki/List_of_political_parties_in_India",
      "Image":"Assets/Images/Details2.png"
    },
    {
      "Text1":"Our Ideology",
      "Text2":"The National Party follows a pro ideology. It was founded as an alternative to the Congress hegemony, by emphasizing on the Telugu regional pride and a party for farmers, backward castes and middle class people. Since the 1990s,[14] it has followed an economically liberal policy that has been seen as pro-business and pro-development party. The TDP uses yellow as the background colour for the flag with a hut, wheel and plough symbol in the foreground. A bicycle is used as the official party symbol.",
      "Url":"https://en.wikipedia.org/wiki/List_of_political_parties_in_India",
      "Image":"Assets/Images/Details3.png"
    },
    {
      "Text1":"Our Committees",
      "Text2":"Polit Bureau, Party State Committee, Dist. Party Committees, District Coordination Committee, State Affiliated Presidents, Constituency Co-ordinations Committees, Mandal Committees, Village Committees, Booth Committees",
      "Url":"https://en.wikipedia.org/wiki/List_of_political_parties_in_India",
      "Image":"Assets/Images/Details4.png"
    },
    {
      "Text1":"Our President",
      "Text2":"Mr XYZ was born on 20 April 1950 at Naravaripalle, Chittoor district, Andhra Pradesh in an agricultural family. His father, N. Kharjura Naidu, worked in agriculture and his mother Amanamma was a housewife.Since his village had no school, Chandrababu Naidu attended primary school in Seshapuram until class five and the Chandragiri Government High School until class nine by walking 11 km every day. He went to Tirupati for his higher education, studying there from class 10 until he received his master’s degree. Chandrababu Naidu completed his BA degree in 1972.",
      "Url":"https://en.wikipedia.org/wiki/List_of_political_parties_in_India",
      "Image":"Assets/Images/Details6.png"
    },

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,50,0,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18,0,0,0),
                child: Text("The National Party",
                  style: TextStyle(fontSize: 20),),
              ),
              SizedBox(height: 20,),
              Container(
                height: MediaQuery.of(context).size.height-145,
                color: Color(0xffe5e5e5),
                child: ListView.builder(
                  itemCount: Detailsdata.length,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Detailsdata[index]["Image"]),
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          width: MediaQuery.of(context).size.width-50,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(18,20,10,20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(Detailsdata[index]["Text1"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),),
                                    GestureDetector(
                                      onTap: (){
                                        _launchURL(Detailsdata[index]["Url"]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffffd011),
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                        ),
                                        width: 80,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0,5,0,5),
                                          child: Center(
                                              child: Text("Read More",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text(Detailsdata[index]["Text2"],
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white,fontSize: 18)),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    );
                  },
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
