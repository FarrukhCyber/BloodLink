import 'package:flutter/material.dart';
import 'package:flutter_application_6/pages/WelcomePage.dart';
// import 'package:signup_signin/screens/signup.dart';
//import 'pages/login.dart';
import 'pages/WelcomePage.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signin Homepage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const landing(),
        // '/signup': (context) => const signup_page()
      },
      //home: landing(),
      //home:landing(),
    );
  }
  }
