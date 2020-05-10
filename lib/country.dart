import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryData extends StatefulWidget {
  @override
  _CountryDataState createState() => _CountryDataState();
}

class _CountryDataState extends State<CountryData> {
  List countryData;
  getCountryData() async {
    String url = "https://corona.lmao.ninja/v2/countries?yesterday=false&sort=cases";
    http.Response response = await http.get(url);
    
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromRGBO(116, 116, 191, 1),
        title: Text("Country Statistics"),
      ),
      body: countryData==null ? Center(
        child: CircularProgressIndicator(),
      ): SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: countryData.length,
          itemBuilder: (context, index) {
          return Card(
                      margin: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20.0)),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: ListTile(
                          leading: Column(children: <Widget>[
                            Text(countryData[index]['country'].toString()),
                            Container(
                              child: Image.network(
                                countryData[index]['countryInfo']['flag'],
                                width: 50,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            )
                          ]),
                          title: Column(children: [
                            Text(
                              "CASES: " +
                                countryData[index]['cases'].toString() +
                                  "  [+" +
                                  countryData[index]['todayCases'].toString() +
                                  "]",
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.blueGrey),
                            ),
                            Text(
                              "RECOVERIES: " +
                                  countryData[index]['recovered'].toString(),
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.green),
                            ),
                            Text(
                              "DEATHS: " +
                                  countryData[index]['deaths'].toString() +
                                  "  [+" +
                                  countryData[index]['todayDeaths'].toString() +
                                  "]",
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.red),
                            ),
                            Text(
                              "ACTIVE: " + countryData[index]['active'].toString(),
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                            )
                          ]),
                        ),
                      ),
                    );
        }),
      )),
    );
  }
}
