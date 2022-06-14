import 'package:bloodlink/screens/aboutPage.dart';
import 'package:bloodlink/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:bloodlink/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:bloodlink/screens/user_profile.dart';
import 'dart:convert';
import 'dart:io';
import 'package:bloodlink/utils/user_info.dart';

class navBar extends StatelessWidget {
  final String userName;
  final String userEmail;
  final bool admin;
  navBar(
      {Key? key,
      required this.userName,
      required this.userEmail,
      required this.admin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userName = UserSimplePreferences.getUsername();
    var userEmail = UserSimplePreferences.getEmail();
    var isDonor = UserSimplePreferences.getisDonor();
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: admin == false
                ? Text(userName == null ? "ERROR" : userName)
                : Text("Admin"),
            accountEmail: admin == false
                ? Text(userEmail == null ? "ERROR" : userEmail)
                : const Text(""),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.asset(
                'assets/bloodlink.png',
                fit: BoxFit.cover,
              )),
              backgroundColor: Colors.white,
            ),
            decoration: BoxDecoration(color: Color(0xffc10110)),
          ),
          isDonor == "true"
              ? ListTile(
                  // logout
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () => {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Settings()))
                      })
              : Container(),
          admin == false
              ? ListTile(
                  // logout
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                  onTap: () => {
                    print("User profile clicked"),
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => userProfile(
                              phoneNum: phoneNo,
                            )))
                  },
                )
              : Container(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            onTap: () => {
              print("About Us clicked"),
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => aboutPage()))
            },
          ),
          ListTile(
            // logout
            leading: const Icon(Icons.logout_sharp),
            title: const Text("Logout"),
            onTap: () async => {
              // SharedPreferences prefs = await SharedPreferences.getInstance(),
              // await prefs.clear(),
              UserSimplePreferences.clear(),
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => login()))
            },
          ),
        ],
      ),
    );
  }
}
