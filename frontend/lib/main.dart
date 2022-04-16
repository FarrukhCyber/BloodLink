import 'package:flutter/material.dart';
import 'package:frontend/screens/createBloodRequest.dart';
import 'package:frontend/screens/admin_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homepage(
        userName: "Farrukh",
        key: key,
      ),
    );
  }
}
