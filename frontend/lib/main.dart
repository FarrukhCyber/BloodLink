import 'package:flutter/material.dart';
import 'package:frontend/landingScreen/landingScreen.dart';

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
      routes: {
        '/' : ((context) => LandingScreen(key: key,)),
        // '/login': (context) => ,// Add Login class
        // '/guest': (context) => ,// Add guest class
        // '/signup': (context) => ,// Add signup class
      },
    
      debugShowCheckedModeBanner: false,
     
    );
  }
}
