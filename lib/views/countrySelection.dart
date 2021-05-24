import 'package:corona_tracker/views/homePage.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountrySelection extends StatefulWidget {
  @override
  _CountrySelectionState createState() => _CountrySelectionState();
}

class _CountrySelectionState extends State<CountrySelection> {
  var countrydialcode="+91";
  var countryCode="IN";
  var countryName="India";
  var countryFlag="flags/in.png";
  Future savedetails()async{
    print(countryName);
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString('country', countryName);
    pref.setString('code', countryCode);
    pref.setString('dialcode', countrydialcode);
    pref.setString('flag', countryFlag);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        HomeScreen()), (Route<dynamic> route) => false);

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose your country",
        ),
        leading: Icon(Icons.arrow_back_ios),
        elevation: 5,
      ),
      body: Container(
        alignment: Alignment.center,
        child: CountryListPick(
          appBar: AppBar(
            title: Text('Pick your country'),
          ),
          theme: CountryTheme(
            isShowFlag: true,
            isShowTitle: true,
            isShowCode: true,
            isDownIcon: true,
            showEnglishName: false,
          ),
          initialSelection: '+91',
          // or
          // initialSelection: 'IN'
          onChanged: (CountryCode code) {
            print("entered into print");
            countryCode=code.code;
            countryName=code.name;
            countryFlag=code.flagUri;
            countrydialcode=code.dialCode;
            print(code.name);
            print(code.code);
            print(code.dialCode);
            print(code.flagUri);
          },
        ),
      ),
      floatingActionButton: Container(
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
            savedetails();
          },
        ),
      ),
    );
  }
}
