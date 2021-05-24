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
    var url1 = Uri.parse(
        'https://coronavirus-map.p.rapidapi.com/v1/spots/month');
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
    title.forEach((k, v) => list.add(DateWiseData.fromJson(v)));
    print(list);
    print("worked fine");
    dd = (list[0].totalCases1 + list[1].totalCases1 + list[2].totalCases1 +
        list[3].totalCases1 + list[4].totalCases1) * 100;
    print((list[0].totalCases1 / dd) * 100);
    print((list[4].totalCases1 - list[3].totalCases1).toDouble());
    return country;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext c, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/virus_img.jpg'),
                          fit: BoxFit.fill),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Covid-19 Tracker",
                            style: TextStyle(fontSize: 15, color: Colors.white),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 156,
                                width: 147,
                                child: Column(
                                  children: [
                                    Text(
                                      "Confirmed cases",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(list[0].totalCases1.toString()),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 100,
                                          height: 88,
                                          child: LineChart(
                                              LineChartData(
                                                lineTouchData: LineTouchData(
                                                  touchTooltipData: LineTouchTooltipData(
                                                    tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                                                  ),
                                                  touchCallback: (LineTouchResponse touchResponse) {},
                                                  handleBuiltInTouches: true,
                                                ),
                                                gridData: FlGridData(
                                                  show: false,
                                                ),
                                                titlesData: FlTitlesData(
                                                  bottomTitles: SideTitles(
                                                    showTitles: true,
                                                    reservedSize: 22,
                                                    getTextStyles: (value) => const TextStyle(
                                                      color: Color(0xff72719b),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                    margin: 10,
                                                    getTitles: (value) {
                                                      switch (value.toInt()) {
                                                        case 2:
                                                          return 'SEPT';
                                                        case 7:
                                                          return 'OCT';
                                                        case 12:
                                                          return 'DEC';
                                                      }
                                                      return '';
                                                    },
                                                  ),
                                                  leftTitles: SideTitles(
                                                    showTitles: true,
                                                    getTextStyles: (value) => const TextStyle(
                                                      color: Color(0xff75729e),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                    getTitles: (value) {
                                                      switch (value.toInt()) {
                                                        case 1:
                                                          return '1m';
                                                        case 2:
                                                          return '2m';
                                                        case 3:
                                                          return '3m';
                                                        case 4:
                                                          return '5m';
                                                      }
                                                      return '';
                                                    },
                                                    margin: 8,
                                                    reservedSize: 30,
                                                  ),
                                                ),
                                                borderData: FlBorderData(
                                                  show: true,
                                                  border: const Border(
                                                    bottom: BorderSide(
                                                      color: Color(0xff4e4965),
                                                      width: 4,
                                                    ),
                                                    left: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    right: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    top: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                ),
                                                minX: 0,
                                                maxX: 14,
                                                maxY: 4,
                                                minY: 0,
                                                lineBarsData: linesBarData1(),
                                              ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 156,
                                width: 147,
                                child: Column(
                                  children: [
                                    Text(
                                      "Active",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(details.cactive_cases.toString()),
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
                                height: 156,
                                width: 147,
                                child: Column(
                                  children: [
                                    Text(
                                      "Recovered",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(details.crecovered.toString()),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 156,
                                width: 147,
                                child: Column(
                                  children: [
                                    Text(
                                      "Deaths",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(details.cdeaths.toString()),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
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
