import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/home.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Homepage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 300.0,
              child: Text(
                'Areel Quiz App',
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 0.0,),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20.0),
              width: 300.0,
              child: Text(
                'Test Your IQ',
                style: TextStyle(fontSize: 18.0, letterSpacing: 4.0, color: Colors.deepOrange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
