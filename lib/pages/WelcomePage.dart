import 'package:flutter/material.dart';
import 'package:flutter_application_6/pages/googleSignIn.dart';
import 'signUp1.dart';
import '../api/google_signin_api.dart';
import 'googleSignIn.dart';
import 'package:google_sign_in/google_sign_in.dart';

class landing extends StatefulWidget {
  const landing({Key? key}) : super(key: key);

  @override
  State<landing> createState() => _landingState();
}

class _landingState extends State<landing> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        child: Column(
          children: <Widget>[
            ImageContainer(),
            Buttons(),
          ],
        ),
      ),
    );
  }

  Widget ImageContainer() {
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

  Widget SignUpButton(image, link, label, pad) {
    return Container(
      //margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
      child: ElevatedButton(
          //padding: EdgeInsets.all(1.0),
          //olor: Color.fromARGB(255, 193, 0, 0),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 193, 0, 0)),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 10, horizontal: pad)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),
          onPressed: link,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                //padding: EdgeInsets.all(0.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 193, 0, 0),
                ),
                child: Image.asset(
                  image,
                  height: 32.0,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  //padding: EdgeInsets.only(left: 0, right: 0),
                  child: Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )),
            ],
          )),
    );
  }

  Widget GuestButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
          side: const BorderSide(
              color: Color.fromARGB(255, 193, 0, 0), width: 2.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      child: const Text("Continue as a Guest",
          style: TextStyle(
            color: Color.fromARGB(255, 193, 0, 0),
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

  Widget LogInButton() {
    return TextButton(
        onPressed: () => {
              // Navigator.pushNamed(s
              //   context,
              //   '/signup',
              // ),
              debugPrint("I'm login")
            },
        child: const Text(
          "Log In",
          style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 193, 0, 0),
              fontWeight: FontWeight.bold),
        ));
  }

  onEmailClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => signup(),
    ));
  }

  Future googleSignIn() async {
    try {
      final user = await GoogleSignInApi.login();
      GoogleSignInApi.logout();
      if (user == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Sign in Failed")));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => loggedInPage(user: user),
        ));
      }
    } catch (error) {
      print(error);
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Widget Buttons() {
    return Container(
      padding: EdgeInsets.only(top: 150),
      child: Column(
        children: <Widget>[
          SignUpButton(
              "assets/google.png", googleSignIn, "Continue with Google", 15.0),
          SizedBox(height: 15),
          SignUpButton(
              "assets/mail.png", googleSignIn, "Continue with Email", 20.0),
          SizedBox(height: 15),
          GuestButton(),
          SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "Already have an account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              LogInButton(),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }
}
