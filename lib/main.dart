import 'package:flutter/material.dart';
import 'editAccountDetails/editAccountDetails.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloodLink',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EditAccountDetails(
        key: key,
      ),
    );
  }
}