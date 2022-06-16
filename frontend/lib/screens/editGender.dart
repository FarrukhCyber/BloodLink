import 'package:bloodlink/screens/createBloodRequest.dart';
import 'package:bloodlink/screens/login.dart';
import 'package:bloodlink/screens/registerDonor.dart';
import 'package:bloodlink/screens/viewActiveRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloodlink/widgets/navbar.dart';
import 'package:bloodlink/widgets/optionCard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:bloodlink/screens/myRequests.dart';
import 'package:bloodlink/screens/viewActiveRequest.dart';
import 'package:bloodlink/utils/user_info.dart';

class editPhone extends StatefulWidget {
  const editPhone({Key? key}) : super(key: key);

  @override
  State<editPhone> createState() => _editPhoneState();
}

class _editPhoneState extends State<editPhone> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
            width: width,
            child: ListView(children: <Widget>[
              Column(
                children: [AppBarFb2(), Text("Gender")],
              ),
            ])));
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
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.keyboard_arrow_left,
      //     color: accentColor,
      //   ),
      //   onPressed: () {},
    );
  }
}
