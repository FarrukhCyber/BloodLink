import 'package:bloodlink/screens/addDonor.dart';
import 'package:flutter/material.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:bloodlink/screens/editEmail.dart';
import 'package:bloodlink/screens/editPhone.dart';
import 'package:bloodlink/screens/editAge.dart';
import 'package:bloodlink/screens/editName.dart';
import 'package:bloodlink/screens/editBlood.dart';
import 'package:bloodlink/screens/editPassword.dart';
import 'package:bloodlink/screens/editGender.dart';
import 'package:bloodlink/screens/editRegion.dart';

var isDonor = UserSimplePreferences.getisDonor();

class viewProfile extends StatefulWidget {
  const viewProfile({Key? key}) : super(key: key);

  @override
  State<viewProfile> createState() => _viewProfileState();
}

class _viewProfileState extends State<viewProfile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    print(isDonor);
    print("I am here");
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: width,
            child: ListView(children: <Widget>[
              Column(
                children: [
                  AppBarFb2(),
                  editSomething2(
                    text: "Name",
                    func: "name",
                    value: UserSimplePreferences.getUsername() ?? "",
                  ),
                  editSomething2(
                    text: "Email",
                    func: "email",
                    value: UserSimplePreferences.getEmail() ?? "",
                  ),
                  editSomething2(
                    text: "Password",
                    func: "password",
                    value: UserSimplePreferences.getPassword() ?? "",
                  ),
                ],
              ),
            ]),
          ),
        ));
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
    );
  }
}

class editSomething extends StatelessWidget {
  @override
  final String text;
  final String func;
  final String value;
  editSomething(
      {required this.text, required this.func, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
      // left: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          Card(
            elevation: 0,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              // // onTap: () => {
              // //   if (func == "email")
              // //     Navigator.of(context).push(MaterialPageRoute(
              // //         builder: (context) => editEmail(key: key)))
              // //   else if (func == "password")
              // //     Navigator.of(context).push(MaterialPageRoute(
              // //         builder: (context) => editPassword(key: key)))
              // //   else if (func == "phone")
              // //     Navigator.of(context).push(MaterialPageRoute(
              // //         builder: (context) => editPhone(
              // //               forget: false,
              // //             )))
              // //   else if (func == "age")
              // //     Navigator.of(context).push(MaterialPageRoute(
              // //         builder: (context) => editAge(key: key)))
              // //   else if (func == "blood")
              // //     Navigator.of(context).push(MaterialPageRoute(
              // //         builder: (context) => editBlood(key: key)))
              // //   else if (func == "name")
              // //     Navigator.of(context).push(MaterialPageRoute(
              // //         builder: (context) => editName(key: key)))
              // //   else if (func == "region")
              // //     Navigator.of(context).push(MaterialPageRoute(
              // //         builder: (context) => editRegion(key: key)))
              // //   else if (func == "gender")
              // //     Navigator.of(context).push(MaterialPageRoute(
              // //         builder: (context) => editGender(key: key)))
              // },
              child: SizedBox(
                  // width: MediaQuery.of(context).size.width *
                  // 0.85, // determines the size of the card
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              text,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () => {print("i was clicked")},
                                child: Text("Edit")),
                          ],
                        ),
                      ),
                      Text(
                        value,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  )),
            ),
          ),
          Divider(
            color: Colors.red,
          )
        ],
      ),
    );
  }
}

class editSomething2 extends StatelessWidget {
  @override
  final String text;
  final String func;
  final String value;
  editSomething2(
      {required this.text, required this.func, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.width * 0.05;
    return Container(
      margin: EdgeInsets.only(top: ht),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text, style: TextStyle(fontSize: 20)),
              SizedBox(
                height: ht * .5,
              ),
              Text(
                value,
                style: TextStyle(fontSize: 15),
              ),
              Divider(
                color: Colors.red,
              ),
              Align(
                alignment: Alignment(1, 0),
                child: InkWell(
                  onTap: () => {print("i was clicked")},
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
