import 'package:flutter/material.dart';
import 'visual/homePage.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Day-Night Theme Example',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }

  ThemeData getThemeBasedOnTime() {
    var now = DateTime.now();
    var isMorning = now.hour < 12;

    return isMorning ? ThemeData.dark() : ThemeData.light();
  }
}

