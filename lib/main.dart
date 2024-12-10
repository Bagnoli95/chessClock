import 'package:chess_clock/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool clockMode = false; //True if digital mode and false if analogic
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('vi'),
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: MyHomePage(),
      ),
    );
  }
}
