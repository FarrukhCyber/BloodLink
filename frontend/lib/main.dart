import 'package:flutter/material.dart';
// import 'package:signup_signin/screens/signup.dart';
import 'package:signup_signin/screens-2/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/user_info.dart';
import 'package:flutter/services.dart';

// imp https://dart.dev/null-safety/unsound-null-safety
/*
flutter run --no-sound-null-safety lib/main.dart
*/
// flutter cook book
// flutter gallery

// void main() { // orignal one
//   runApp(const MyApp());
// }

Future main() async { // new one
  WidgetsFlutterBinding.ensureInitialized();
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
