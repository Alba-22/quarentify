import 'dart:html';

import 'package:flutter/material.dart';
import 'package:quarentify/home.screen.dart';

import 'functions.dart';

void main() {
  // print(window.location.href);
  // String accessToken = getAuthToken();
  // print(accessToken);
  // ! UNCOMMENT ABOVE LINES AND COMMENT BELOW
  String accessToken = "";
  runApp(MyApp(accessToken: accessToken));
}

class MyApp extends StatelessWidget {

  final String accessToken;

  const MyApp({Key key, this.accessToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1DB954),
        backgroundColor: Color(0xFF212121),
        scaffoldBackgroundColor: Color(0xFF121212),
        textSelectionColor: Colors.white,
        fontFamily: "Gotham-Medium",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(accessToken: accessToken),
    );
  }
}