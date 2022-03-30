import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 243, 243, 35),
      body: Column(
        children: <Widget>[
          Logo(key: key),
          Buttons(
            key: key,
          )
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60),
      child: const Image(
        image: AssetImage("assets/bloodlink.png"),
        height: 220,
        width: 220,
      ),
      alignment: Alignment.center,
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 193, 0, 0)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 15, horizontal: 80)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ))),
      child: const Text(
        "Login",
        style: TextStyle(fontSize: 20.0),
      ),
      onPressed: () => {
        // Navigator.pushNamed(
        //   context,
        //   '/login',
        // ),
        print("I'm login")
      },
    );
  }
}

class GuestButton extends StatelessWidget {
  const GuestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      child: const Text("Continue as a Guest",
          style: TextStyle(
            color: Colors.red,
            fontSize: 20.0,
          )),
      onPressed: () => {
        // Navigator.pushNamed(
        //   context,
        //   '/guest',
        // ),

        print("I'm guest")
      },
    );
  }
}

class SigupButton extends StatelessWidget {
  const SigupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {
              // Navigator.pushNamed(s
              //   context,
              //   '/signup',
              // ),
              debugPrint("I'm signup")
            },
        child: const Text(
          "Don't have an Account? Sign up",
          style: TextStyle(fontSize: 15, color: Colors.red),
        ));
  }
}

class Buttons extends StatelessWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 150),
      child: Column(
        children: <Widget>[
          LoginButton(
            key: key,
          ),
          SizedBox(height: 15),
          GuestButton(
            key: key,
          ),
          SizedBox(height: 15),
          SigupButton(
            key: key,
          )
        ],
      ),
    );
  }
}
