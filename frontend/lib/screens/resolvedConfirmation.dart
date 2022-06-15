import 'package:bloodlink/screens/homepage.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:flutter/material.dart';

class ResolvedConfirmation extends StatelessWidget {
  bool zarourat;

  ResolvedConfirmation({Key? key, required this.zarourat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: <Widget>[
          AppBarFb2(),
          PopUp(
            zarourat: zarourat,
          ),
        ],
      ),
    );
  }
}

class AppBarFb2 extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppBarFb2({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xffc10110);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return AppBar(
      centerTitle: true,
      title: const Text("BloodLink", style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
      actions: [
        // IconButton(
        // icon: Icon(
        // Icons.share,
        // color: accentColor,
        // ),
        // onPressed: () {},
        // )
      ],
      leading: IconButton(
        icon: Icon(
          Icons.keyboard_arrow_left,
          color: accentColor,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => homepage(
                  userName: UserSimplePreferences.getUsername() ?? "",
                  key: key)));
        },
      ),
    );
  }
}

class PopUp extends StatelessWidget with PreferredSizeWidget {
  bool zarourat;
  @override
  final Size preferredSize;

  PopUp({Key? key, required this.zarourat})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    if (zarourat == true) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.2, 0, 0),
          child: Column(
            children: [
              Icon(Icons.check_circle,
                  color: Colors.red,
                  size: MediaQuery.of(context).size.width * 0.5),
              Text(
                "\n Successfull",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.06),
              ),
              Text(
                "\n Your request has been marked as Resolved",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.2, 0, 0),
          child: Column(
            children: [
              Icon(Icons.check_circle,
                  color: Colors.red,
                  size: MediaQuery.of(context).size.width * 0.5),
              Text(
                "\nSuccessfull",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.06),
              ),
              Text(
                "\n Your request has been marked as Active",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
