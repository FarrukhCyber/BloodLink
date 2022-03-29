import 'package:flutter/material.dart';
// import 'package:signup_signin/screens/signup.dart';
import 'package:signup_signin/screens-2/login.dart';

// imp https://dart.dev/null-safety/unsound-null-safety
// flutter cook book
// flutter gallery

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signin Homepage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const login(),
        // '/signup': (context) => const signup_page()
      },
      // home: login(),
    );
  }
}
