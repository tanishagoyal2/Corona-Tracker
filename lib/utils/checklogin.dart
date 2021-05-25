import 'package:corona_tracker/views/homePage.dart';
import 'package:corona_tracker/views/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class checkLogin extends StatefulWidget {
  @override
  _checkLoginState createState() => _checkLoginState();
}

class _checkLoginState extends State<checkLogin> {
  @override
  var country;
  Future getData()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    country=pref.getString("country");
    print(country);
    return country;
  }
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (c,snapshot){
        if(snapshot.hasData && snapshot.connectionState==ConnectionState.done){
          return HomeScreen();
        }
        else if(snapshot.data==null && snapshot.connectionState==ConnectionState.done){
          return SplashScreen();
        }
        else if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else{
          return Text("something went wrong");
        }
      },
    );
  }
}
