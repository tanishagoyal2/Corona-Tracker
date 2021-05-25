import 'package:corona_tracker/constants/constantColors.dart';
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
                image: AssetImage('assets/SplashScreen.png'),
                fit: BoxFit.cover
              )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[ Center(
              child: GestureDetector(
                child: Icon(Icons.swipe,color:Colors.white,size: 50,),
                onVerticalDragUpdate: (dragupdatedetails){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    CountrySelection()), (Route<dynamic> route) => false);
                  },
                ),
            ),
              Text("Swipe Up To Begin",style: TextStyle(fontSize: 20,color:Colors.white),)
            ]
          ),
        ]
      )
    );
  }
}
