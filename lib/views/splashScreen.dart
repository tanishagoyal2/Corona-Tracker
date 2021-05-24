import 'package:flutter/material.dart';

import 'homePage.dart';
import 'countrySelection.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/worldmap.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 150),
                  alignment: Alignment.topCenter,
                  child: Text("Coronavirus Tracker",style: TextStyle(color: Colors.white),),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:[ GestureDetector(
                    child: Icon(Icons.swipe,color: Colors.white,size: 50,),
                    onVerticalDragUpdate: (dragupdatedetails){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        CountrySelection()), (Route<dynamic> route) => false);
                      },
                    ),
                    Text("Swipe Up To Begin",style: TextStyle(color: Colors.white,fontSize: 20),)
                  ]
                ),
              )
            ],
          ),
        ]
      )
    );
  }
}
