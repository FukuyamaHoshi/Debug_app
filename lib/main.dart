import 'package:flutter/material.dart';
import 'package:debug_app/couse_page.dart';
import 'package:debug_app/question_page.dart';
import 'package:debug_app/result_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResultPage(),
    );
  }
}
