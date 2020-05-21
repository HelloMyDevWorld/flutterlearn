import 'package:discover/travel/screens/main_screen.dart';
import 'package:discover/travel/util/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TravelApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TravelApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      home: MainScreen(),
    );
  }
}
