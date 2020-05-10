import 'dart:convert';
import 'package:covid19tracker/country.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_pro/carousel_pro.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map worldData;
  Map kenyaData;
  getTotal() async {
    String url = "https://corona.lmao.ninja/v2/all";
    http.Response response = await http.get(url);
    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

  getKenyadata() async {
    String url = "https://corona.lmao.ninja/v2/countries/KENYA";
    http.Response response = await http.get(url);
    setState(() {
      kenyaData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getKenyadata();
    getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 249, 249, 1),
      body: worldData == null || kenyaData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        
                          gradient: LinearGradient(colors: [
                        Color.fromRGBO(116, 116, 191, 1),
                        Color.fromRGBO(52, 138, 199, 1)
                        
                      ])
                      
                      ),
                      
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height*0.4,
                          width: MediaQuery.of(context).size.width,
                          child: Carousel(
                            images: [
                              Image.asset("assets/distancing.jpeg",
                              fit: BoxFit.cover, ),
                              Image.asset("assets/wash.jpeg",
                              fit: BoxFit.cover, ),
                              Image.asset("assets/dist.jpeg",
                              fit: BoxFit.cover,
                              ),
                        
                              
                            ],
                            dotSize: 4.0,
                            dotSpacing: 15.0,
                            dotColor: Colors.lightGreenAccent,
                            indicatorBgPadding: 5.0,
                            autoplayDuration: Duration(
                              seconds: 5
                            ),
                            animationDuration: Duration(
                              seconds: 1
                            ),
                            dotBgColor: Colors.purple.withOpacity(0),
                            borderRadius: true,
                            moveIndicatorFromBottom: 180.0,
                            noRadiusForIndicator: true,
                          )),
                    ),
                    StatsTile(
                      title: "CONFIRMED CASES",
                      cases: worldData['cases'].toString(),
                      usedColor: Colors.blueGrey,
                      icon: Icon(
                        Icons.insert_chart,
                        size: 40,
                        color: Colors.blueGrey,
                      ),
                    ),
                    StatsTile(
                      title: "RECOVERIES",
                      cases: worldData['recovered'].toString(),
                      usedColor: Colors.green,
                      icon: Icon(
                        Icons.mood,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                    StatsTile(
                      title: "DEATHS",
                      cases: worldData['deaths'].toString(),
                      usedColor: Colors.red,
                      icon: Icon(
                        Icons.mood_bad,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                    StatsTile(
                      title: "ACTIVE CASES",
                      cases: worldData['active'].toString(),
                      usedColor: Colors.black,
                      icon: Icon(
                        Icons.insert_chart,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Center(
                        child: Text(
                          "Covid-19 Statistics for Kenya",
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Color.fromRGBO(52, 138, 199, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20.0)),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: ListTile(
                          leading: Column(children: <Widget>[
                            Text(kenyaData['country'].toString()),
                            Container(
                              child: Image.network(
                                kenyaData['countryInfo']['flag'],
                                width: 50,
                                height: 40,
                              ),
                            )
                          ]),
                          title: Column(children: [
                            Text(
                              "CASES: " +
                                  kenyaData['cases'].toString() +
                                  "  [+" +
                                  kenyaData['todayCases'].toString() +
                                  "]",
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.blueGrey),
                            ),
                            Text(
                              "RECOVERIES: " +
                                  kenyaData['recovered'].toString(),
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.green),
                            ),
                            Text(
                              "DEATHS: " +
                                  kenyaData['deaths'].toString() +
                                  "  [+" +
                                  kenyaData['todayDeaths'].toString() +
                                  "]",
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.red),
                            ),
                            Text(
                              "ACTIVE: " + kenyaData['active'].toString(),
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                            )
                          ]),
                        ),
                      ),
                    ),
                     GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryData()));
                       },
                                            child: Container(
                         alignment: Alignment.center,
                         margin: EdgeInsets.all(50.0),
                         width: MediaQuery.of(context).size.width,
                         child: Padding(
                           padding: const EdgeInsets.all(15.0),
                           child: Text("Statistics by Country",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 20.0
                           ),
                           ),
                         ),
                         decoration: BoxDecoration(
                           gradient: LinearGradient(colors: [
                          Color.fromRGBO(116, 116, 191, 1),
                          Color.fromRGBO(52, 138, 199, 1),]
                         ),
                         )
                       ),
                     ), 

                  ],
                ),
              ),
            ),
    );
  }
}

class StatsTile extends StatelessWidget {
  final String cases;
  final Icon icon;
  final Color usedColor;
  final String title;
  StatsTile({this.title, this.cases, this.icon, this.usedColor});
  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.white,
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20.0)),
      child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 25.0,
                    color: usedColor,
                    fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: icon,
                trailing: Text(
                  cases,
                  style: TextStyle(
                      fontSize: 28.0,
                      color: usedColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          )),
    );
  }
}
