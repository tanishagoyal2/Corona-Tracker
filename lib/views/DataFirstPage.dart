import 'dart:convert';

import 'package:corona_tracker/modals/dateWiseData.dart';
import 'package:corona_tracker/modals/fetchDetailsCountryWise.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataFirstPage extends StatefulWidget {
  @override
  _DataFirstPageState createState() => _DataFirstPageState();
}

class _DataFirstPageState extends State<DataFirstPage> {
  @override

  var country;
  var code;
  var countryName;
  var countryCode;
  var countryFlag;
  var countrydialcode;
  var details;
  var dd;
  var list = [];

  Future getData() async {
    print("get data called");
    SharedPreferences pref = await SharedPreferences.getInstance();
    country = pref.getString("country");
    code=pref.getString("code");
    country="india";
    print(country);
    final url =
    Uri.parse('https://coronavirus-map.p.rapidapi.com/v1/summary/latest');
    var params = {
      "region": country,
    };
    var response = await get(
      url,
      headers: {
        "x-rapidapi-key": "cb32e83aadmshf7538630f70d9ccp1422d9jsn152d1c5be9f5",
        "x-rapidapi-host": "coronavirus-map.p.rapidapi.com",
        "useQueryString": "true"
      }
    );
    details = jsonDecode(response.body);
    print(details['data']['regions'].length);
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
    int count = 0;
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
        int count = 0;
        res1.forEach((k, v) {
          if (count < 10) {
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
    return datarows;
  }

  Future setData()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString('country', countryName);
    pref.setString('code', countryCode);
    pref.setString('dialcode', countrydialcode);
    pref.setString('flag', countryFlag);
    setState(() {
    });
  }

  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext c, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var total_casesDiff = list[0].totalCases1 - list[1].totalCases1;
            var criticalDiff = list[0].critical1 - list[1].critical1;
            var recoveredDiff = list[0].recovered1 - list[1].recovered1;
            var deathsDiff = list[0].deaths1 - list[1].deaths1;
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
//                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Covid-19 Tracker",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              /*CountryListPick(
                                useUiOverlay: true,
                                appBar: AppBar(
                                  title: Text('Pick your country'),
                                ),
                                theme: CountryTheme(
                                  isShowFlag: true,
                                  isShowTitle: true,
                                  isShowCode: true,
                                  isDownIcon: true,
                                  showEnglishName: true,
                                  alphabetTextColor: Colors.white,
                                ),
                                initialSelection: code,
                                // or
                                // initialSelection: 'IN'
                                onChanged: (CountryCode code) {
                                  print("entered into print");
                                  countryCode=code.code;
                                  countryName=code.name;
                                  countryFlag=code.flagUri;
                                  countrydialcode=code.dialCode;
                                  setData();
                                  print(code.name);
                                  print(code.code);
                                  print(code.dialCode);
                                  print(code.flagUri);
                                },
                              ),*/
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                                constraints: BoxConstraints(maxWidth: 150),
                                child: DropdownButton<String>(
                                  isDense: true,
                                  value: country,
                                  isExpanded: true,
                                  //elevation: 5,
                                  underline: Container(
                                    height: 2,
                                    color: Colors.white,
                                  ),
                                  style: TextStyle(color: Colors.black,fontSize: 20),

                                  items: <String>["afghanistan",
                                    "albania",
                                    "algeria",
                                    "andorra",
                                    "angola",
                                    "argentina",
                                    "armenia",
                                    "australia",
                                    "austria",
                                    "azerbaijan",
                                    "bahrain",
                                    "bangladesh",
                                    "belarus",
                                    "belgium",
                                    "belize",
                                    "bolivia",
                                    "bosnia_and_herzegovina",
                                    "botswana",
                                    "brazil",
                                    "bulgaria",
                                    "burkina_faso",
                                    "cabo_verde",
                                    "cambodia",
                                    "cameroon",
                                    "canada",
                                    "chile",
                                    "colombia",
                                    "costa_rica",
                                    "croatia",
                                    "cuba",
                                    "curacao",
                                    "cyprus",
                                    "czechia",
                                    "denmark",
                                    "dominican_republic",
                                    "ecuador",
                                    "egypt",
                                    "el_salvador",
                                    "estonia",
                                    "eswatini",
                                    "ethiopia",
                                    "finland",
                                    "france",
                                    "french_guiana",
                                    "french_polynesia",
                                    "gabon",
                                    "germany",
                                    "ghana",
                                    "greece",
                                    "guadeloupe",
                                    "guatemala",
                                    "guinea",
                                    "guyana",
                                    "haiti",
                                    "honduras",
                                    "hungary",
                                    "india",
                                    "indonesia",
                                    "iran",
                                    "iraq",
                                    "ireland",
                                    "israel",
                                    "italy",
                                    "ivory_coast",
                                    "jamaica",
                                    "japan",
                                    "jordan",
                                    "kazakhstan",
                                    "kenya",
                                    "kuwait",
                                    "kyrgyzstan",
                                    "latvia",
                                    "libya",
                                    "lithuania",
                                    "luxembourg",
                                    "madagascar",
                                    "malawi",
                                    "malaysia",
                                    "maldives",
                                    "mali",
                                    "malta",
                                    "mauritania",
                                    "mayotte",
                                    "mexico",
                                    "moldova",
                                    "mongolia",
                                    "montenegro",
                                    "morocco",
                                    "mozambique",
                                    "myanmar",
                                    "namibia",
                                    "nepal",
                                    "netherlands",
                                    "nigeria",
                                    "north_macedonia",
                                    "norway",
                                    "oman",
                                    "pakistan",
                                    "palestine",
                                    "panama",
                                    "papua_new_guinea",
                                    "paraguay",
                                    "peru",
                                    "philippines",
                                    "poland",
                                    "portugal",
                                    "qatar",
                                    "reunion",
                                    "romania",
                                    "russia",
                                    "rwanda",
                                    "saudi_arabia",
                                    "senegal",
                                    "serbia",
                                    "singapore",
                                    "slovakia",
                                    "slovenia",
                                    "somalia",
                                    "south_africa",
                                    "south_korea",
                                    "spain",
                                    "sri_lanka",
                                    "sudan",
                                    "suriname",
                                    "sweden",
                                    "switzerland",
                                    "syria",
                                    "tajikistan",
                                    "thailand",
                                    "togo",
                                    "trinidad_and_tobago",
                                    "tunisia",
                                    "turkey",
                                    "uganda",
                                    "uk",
                                    "ukraine",
                                    "united_arab_emirates",
                                    "uruguay",
                                    "usa",
                                    "uzbekistan",
                                    "venezuela",
                                    "zambia",
                                    "zimbabwe",
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,style: TextStyle(color: Colors.black),),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    "Country",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      country= value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () {
                              setState(() {});
                              return ;
                            },
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Confirmed",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                list[0].totalCases1.toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  total_casesDiff > 0
                                                      ? Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.red,
                                                  )
                                                      : Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                    total_casesDiff
                                                        .abs()
                                                        .toString(),
                                                    style: total_casesDiff > 0
                                                        ? TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold)
                                                        : TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Critical",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                list[0].critical1.toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                              Row(
                                                children: [
                                                  criticalDiff > 0
                                                      ? Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.red,
                                                  )
                                                      : Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                    criticalDiff
                                                        .abs()
                                                        .toString(),
                                                    style: criticalDiff > 0
                                                        ? TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold)
                                                        : TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Recovered",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                list[0].recovered1.toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                              Row(
                                                children: [
                                                  recoveredDiff > 0
                                                      ? Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.red,
                                                  )
                                                      : Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                    recoveredDiff
                                                        .abs()
                                                        .toString(),
                                                    style: recoveredDiff > 0
                                                        ? TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold)
                                                        : TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Deaths",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                list[0].deaths1.toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.purple),
                                              ),
                                              Row(
                                                children: [
                                                  deathsDiff > 0
                                                      ? Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.red,
                                                  )
                                                      : Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                    deathsDiff.abs().toString(),
                                                    style: deathsDiff > 0
                                                        ? TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold)
                                                        : TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
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
}
