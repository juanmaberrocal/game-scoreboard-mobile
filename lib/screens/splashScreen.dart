import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

Future ping() async {
  final response =
      await http.get(
        'http://localhost:3000/ping',
      );


  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return true;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() =>  _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int retryLimit = 5;
  int retryCount = 0;

  loadApi() {
    ping().then((resp) {
      print("nailed it");
    }).catchError((err) {
      retryCount++;

      if (retryCount < retryLimit) {
        print(retryCount);
        print("try again");
        loadApi();
      } else {
        print("failed");
        throw Exception('Failed to load post');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/game-die_1f3b2.png"),
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: Text("Game Scoreboard", style: TextStyle(fontSize: 40.0, color: Colors.white),),
                  ),
                ]
              )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
              child: Text("Developed by Juanma", style: TextStyle(fontSize: 16.0, color: Colors.white),),
            ),
          ]
        )
      )
    );
  }
}
