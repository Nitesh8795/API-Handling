import 'package:api_handling/Last_Example.dart';
import 'package:api_handling/example_three.dart';
import 'package:api_handling/home.dart';
import 'package:api_handling/other_example2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LastExample(),
    );
  }
}

