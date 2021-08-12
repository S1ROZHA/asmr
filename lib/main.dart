import 'package:flutter/material.dart';

import 'package:asmr/screens/welcome/WelcomeScreen.dart';
import 'package:asmr/screens/AsmrHome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASMR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: AsmrHome(),
    );
  }
}
