import 'package:bloodlink/screens/homepage.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'admin_dashboard.dart';

class RequestConfirmation extends StatelessWidget {
  var admin;
  RequestConfirmation({Key? key, required this.admin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: <Widget>[
          AppBarFb2(admin: admin),
          PopUp(),
        ],
      ),
      //   ),
      // ),
      // ),
    );
  }
}

class AppBarFb2 extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  var admin;

  AppBarFb2({Key? key, required this.admin})
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
        onPressed: () => {
          if (admin == true)
            {
              print("here in admin"),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => adminHomepage(
                        key: key,
                        // userName: UserSimplePreferences.getUsername(),
                      )))
            }
          else
            {
              print("here in User"),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => homepage(
                        key: key,
                        userName: UserSimplePreferences.getUsername() ?? "",
                      )))
            }
        },
      ),
    );
  }
}

class PopUp extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  PopUp({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
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
              "\nRequest Initiated",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.06),
            ),
            Text(
              "\nPlease mark it resolved from main screen\n once a donor reaches you out.",
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
