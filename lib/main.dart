import 'dart:html';

import 'package:flutter/material.dart';
import 'package:quarentify/home.screen.dart';

import 'functions.dart';

void main() {
  print(window.location.href);
  String accessToken = getAuthToken();
  print(accessToken);
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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(accessToken: accessToken),
    );
  }
}