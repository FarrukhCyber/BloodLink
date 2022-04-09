import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:bloodlink/screens/phone_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloodlink/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:flutter/services.dart';

Future main() async { // new one
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserSimplePreferences.init();

  runApp(MyApp());
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
