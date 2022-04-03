import 'package:flutter/material.dart';
import 'signUp1.dart';


class signup extends StatefulWidget {
  const signup({ Key? key }) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              colors: [Colors.white, Color.fromARGB(255, 226, 106, 106)],
              stops: [0.0, 1.0],
              tileMode: TileMode.repeated),
        ),
      ),
    );
  }
}
