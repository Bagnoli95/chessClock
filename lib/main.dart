import 'package:chess_clock/pages/home.dart';
import 'package:chess_clock/pages/pro_main.dart';
import 'package:chess_clock/pages/sm_main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool clockMode = false; //True if digital mode and false if analogic
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: smClockScreen(clockMode: clockMode),
        // body: proClockScreen(clockMode: clockMode),
        // body: MyHomePage(),
      ),
    );
  }
}
