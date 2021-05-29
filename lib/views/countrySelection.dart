import 'package:corona_tracker/views/homePage.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountrySelection extends StatefulWidget {
  @override
  _CountrySelectionState createState() => _CountrySelectionState();
}

class _CountrySelectionState extends State<CountrySelection> {
  List<String> countries=["afghanistan",
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
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose your country",
        ),
        leading: Icon(Icons.arrow_back_ios),
        elevation: 5,
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (c,index){
          return countryTile(countries[index],index);
        },
      ),
      /*floatingActionButton: Container(
        height: 50,
        width: 80,
        child: FloatingActionButton(
          child: Row(
            children: [
              Icon(
                Icons.save,
                size: 30,
              ),
              Text(
                "Save",
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          isExtended: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          onPressed: () {
          },
        ),
      ),*/
    );
  }
}
class countryTile extends StatefulWidget {
  String countryName;
  int index;
  countryTile(this.countryName,this.index);
  @override
  _countryTileState createState() => _countryTileState();
}

class _countryTileState extends State<countryTile> {
  @override
  bool pressed=false;
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){setState(() {
        pressed=!pressed;
        savedetails();
      });},
      child: Card(
        color: pressed?Colors.grey[400]:Colors.white,
        elevation: 1,
        child: ListTile(
          leading: Text((widget.index+1).toString()),
          title: Text(widget.countryName),),
      ),
    );
  }
  Future savedetails()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString('country', widget.countryName);
    /*pref.setString('code', countryCode);
    pref.setString('dialcode', countrydialcode);
    pref.setString('flag', countryFlag);*/
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        HomeScreen()), (Route<dynamic> route) => false);

  }
}
