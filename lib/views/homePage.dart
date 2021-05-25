import 'dart:convert';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:corona_tracker/modals/fetchDetailsCountryWise.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:corona_tracker/modals/dateWiseData.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  var country;
  FetchDetails details;
  var dd;
  var list = [];

  Future getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    country = pref.getString("country");
    final url =
        Uri.parse('https://coronavirus-map.p.rapidapi.com/v1/summary/region');
    var params = {
      "region": country,
    };
    final newuri = url.replace(queryParameters: params);
    var response = await get(
      newuri,
      headers: {
        "x-rapidapi-key": "cb32e83aadmshf7538630f70d9ccp1422d9jsn152d1c5be9f5",
        "x-rapidapi-host": "coronavirus-map.p.rapidapi.com",
        "useQueryString": "true",
      },
    );
    details = FetchDetails.fromJson(jsonDecode(response.body));
    print(details.stotal_cases);
    var url1 =
        Uri.parse('https://coronavirus-map.p.rapidapi.com/v1/spots/month');
    var newuri1 = url1.replace(queryParameters: params);
    var response1 = await get(
      newuri1,
      headers: {
        "x-rapidapi-key": "cb32e83aadmshf7538630f70d9ccp1422d9jsn152d1c5be9f5",
        "x-rapidapi-host": "coronavirus-map.p.rapidapi.com",
        "useQueryString": "true",
      },
    );
    var title = jsonDecode(response1.body)['data'];
    int count=0;
    title.forEach((k, v) {
      if (count < 5) {
        list.add(DateWiseData.fromJson(v));
      }
      count++;
    });
    return country;
  }

  List<DataRow> datarows = [];

  Future countryData() async {
    var url = "https://coronavirus-map.p.rapidapi.com/v1/summary/latest";
    await get(
        Uri.parse('https://coronavirus-map.p.rapidapi.com/v1/summary/latest'),
        headers: {
          "x-rapidapi-key":
              "cb32e83aadmshf7538630f70d9ccp1422d9jsn152d1c5be9f5",
          "x-rapidapi-host": "coronavirus-map.p.rapidapi.com",
          "useQueryString": "true"
        }).then((response) {
      if (response.statusCode >= 200 && response.statusCode <= 205) {
        var responseData = jsonDecode(response.body);
        var res1 = responseData["data"]["regions"];
        print(res1);
        int count = 0;
        res1.forEach((k, v) {
          if (count < 10) {
            print("data row called");
            datarows.add(
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                    res1[k]["name"].toString(),
                    softWrap: true,
                    style: TextStyle(fontSize: 12),
                  )),
                  DataCell(Text(res1[k]['total_cases'].toString(),
                      style: TextStyle(fontSize: 12))),
                  DataCell(Text(res1[k]['active_cases'].toString(),
                      style: TextStyle(fontSize: 12))),
                  DataCell(Text(res1[k]['recovered'].toString(),
                      style: TextStyle(fontSize: 12))),
                  DataCell(Text(res1[k]['deaths'].toString(),
                      style: TextStyle(fontSize: 12))),
                ],
              ),
            );
            count++;
          }
        });
      }
    });
    print(datarows);
    return datarows;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext c, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var total_casesDiff=list[0].totalCases1-list[1].totalCases1;
            var criticalDiff=list[0].critical1-list[1].critical1;
            var recoveredDiff=list[0].recovered1-list[1].recovered1;
            var deathsDiff=list[0].deaths1-list[1].deaths1;
            return Container(
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/virus_img.jpg'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50, top: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Covid-19 Tracker",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              FlatButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      country,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: 146,
                                        width: 142,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Confirmed",
                                              style:
                                                  TextStyle(color: Colors.grey,fontSize: 16),
                                            ),
                                            Text(
                                                list[0].totalCases1.toString(),
                                              style:
                                              TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                total_casesDiff>0?Icon(Icons.arrow_upward,color: Colors.red,):Icon(Icons.arrow_downward,color: Colors.green,),
                                                Text(
                                                  total_casesDiff.abs().toString(),
                                                  style:
                                                  total_casesDiff>0?TextStyle(color:Colors.red,fontSize: 18,fontWeight: FontWeight.bold):TextStyle(color:Colors.green,fontSize: 18,fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: 146,
                                        width: 142,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Critical",
                                              style:
                                              TextStyle(color: Colors.grey,fontSize: 16),
                                            ),
                                            Text(
                                              list[0].critical1.toString(),
                                              style:
                                              TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blue),
                                            ),
                                            Row(
                                              children: [
                                                criticalDiff>0?Icon(Icons.arrow_upward,color: Colors.red,):Icon(Icons.arrow_downward,color: Colors.green,),
                                                Text(
                                                  criticalDiff.abs().toString(),
                                                  style:
                                                  criticalDiff>0?TextStyle(color:Colors.red,fontSize: 18,fontWeight: FontWeight.bold):TextStyle(color:Colors.green,fontSize: 18,fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: 146,
                                        width: 142,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Recovered",
                                              style:
                                              TextStyle(color: Colors.grey,fontSize: 16,),
                                            ),
                                            Text(
                                              list[0].recovered1.toString(),
                                              style:
                                              TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green),
                                            ),
                                            Row(
                                              children: [
                                                recoveredDiff>0?Icon(Icons.arrow_upward,color: Colors.red,):Icon(Icons.arrow_downward,color: Colors.green,),
                                                Text(
                                                  recoveredDiff.abs().toString(),
                                                  style:
                                                  recoveredDiff>0?TextStyle(color:Colors.red,fontSize: 18,fontWeight: FontWeight.bold):TextStyle(color:Colors.green,fontSize: 18,fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: 146,
                                        width: 142,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Deaths",
                                              style:
                                              TextStyle(color: Colors.grey,fontSize: 16),
                                            ),
                                            Text(
                                              list[0].deaths1.toString(),
                                              style:
                                              TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.purple),
                                            ),
                                            Row(
                                              children: [
                                                deathsDiff>0?Icon(Icons.arrow_upward,color: Colors.red,):Icon(Icons.arrow_downward,color: Colors.green,),
                                                Text(
                                                  deathsDiff.abs().toString(),
                                                  style:
                                                  deathsDiff>0?TextStyle(color:Colors.red,fontSize: 18,fontWeight: FontWeight.bold):TextStyle(color:Colors.green,fontSize: 18,fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                FutureBuilder(
                                  future: countryData(),
                                  builder: (c, s) {
                                    if (s.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (s.hasData &&
                                        s.connectionState ==
                                            ConnectionState.done) {
                                      return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              columns: [
                                                DataColumn(
                                                    label: Text(
                                                  "Country",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  "Confirmed",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 15),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  "Active",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 15),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  "Recovered",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 15),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  "Deaths",
                                                  style: TextStyle(
                                                      color: Colors.purple,
                                                      fontSize: 15),
                                                )),
                                              ],
                                              rows: datarows));
                                    } else {
                                      return Center(
                                        child: Text("something went wrong"),
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Text("No data found");
          }
        },
      ),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
  }
}
