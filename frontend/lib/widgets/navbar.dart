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
  navBar({Key? key, required this.userName, required this.userEmail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userName = UserSimplePreferences.getUsername();
    var userEmail = UserSimplePreferences.getEmail();
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName == null ? "ERROR" : userName),
            accountEmail: Text(userEmail == null ? "ERROR" : userEmail),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.asset(
                'assets/bloodlink.png',
                fit: BoxFit.cover,
              )),
              backgroundColor: Colors.white,
            ),
            decoration: BoxDecoration(color: Colors.red),
          ),
          ListTile(
              // logout
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () => {
                Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Settings()))
              }),
          ListTile(
            // logout
            leading: Icon(Icons.person),
            title: Text("User Profile"),
            onTap: () => {
              print("User profile clicked"),
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => userProfile(phoneNum: phoneNo,)))
            },
          ),
          ListTile(
            // logout
            leading: Icon(Icons.logout_sharp),
            title: Text("Logout"),
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
