import 'package:bloodlink/screens/addDonor.dart';
import 'package:bloodlink/screens/adminResolvedRequests.dart';
import 'package:bloodlink/screens/pendingRequests.dart';
import 'package:bloodlink/screens/viewActiveRequest.dart';
import 'package:bloodlink/screens/view_request.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'createBloodRequest.dart';
import 'package:bloodlink/widgets/navbar.dart';

class adminHomepage extends StatefulWidget {
  adminHomepage({Key? key}) : super(key: key);

  @override
  State<adminHomepage> createState() => _adminHomepageState();
}

class _adminHomepageState extends State<adminHomepage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
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
        drawer: navBar(
          userName: "Admin",
          userEmail: "Email",
        ),
        // backgroundColor: Color.fromARGB(255, 229, 229, 229),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Center(
              child: Container(
                width: width,
                child: Column(
                  children: [
                    AppBarFb2(),
                    TopBarFb3(
                        title: "BloodLink", upperTitle: "\n Welcome Admin \n "),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    CardWithIconInitiateRequest(
                      text: "Initiate a new Request",
                      symbol: MdiIcons.plusCircle,
                      color: Color(0xff24A979),
                      // newLocation: CreateBloodRequest(key:key),
                    ),
                    CardWithIconPendingRequest(
                        text: "Pending Requests",
                        symbol: Icons.pending_actions_outlined,
                        color: Color.fromARGB(255, 75, 5, 0)),
                    CardWithIconActiveRequest(
                        text: "Active Requests",
                        symbol: MdiIcons.clock,
                        color: Color.fromARGB(255, 193, 0, 0)),
                    CardWithIconResolvedRequest(
                        text: "Resolved Requests",
                        symbol: Icons.check_circle_outline_outlined,
                        color: Color.fromARGB(255, 13, 95, 13)),
                    CardwithIconAddDonor(
                        text: "Add a Donor",
                        symbol: Icons.person_add,
                        color: Color.fromARGB(255, 0, 153, 255))
                  ],
                ),
              ),
            ),
          ],
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
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.keyboard_arrow_left,
      //     color: accentColor,
      //   ),
      //   onPressed: () {},
    );
  }
}

//the second bar
class TopBarFb3 extends StatelessWidget {
  final String title;
  final String upperTitle;
  TopBarFb3({required this.title, required this.upperTitle, Key? key})
      : super(key: key);
  final primaryColor = Color(0xffc10110);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(upperTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal)))
        ],
      ),
    );
  }
}

class initiate extends StatefulWidget {
  const initiate({Key? key}) : super(key: key);

  @override
  State<initiate> createState() => _initiateState();
}

class _initiateState extends State<initiate> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CardWithIconInitiateRequest extends StatefulWidget {
  // final String heading;
  @override
  final String text;
  final IconData symbol;
  final Color color;
  // final Function? newLocation;
  // final Size preferredSize;
  CardWithIconInitiateRequest(
      {required this.text,
      required this.symbol,
      required this.color,
      // required this.newLocation,
      Key? key})
      : super(key: key);

  @override
  State<CardWithIconInitiateRequest> createState() =>
      _CardWithIconInitiateRequestState();
}

class _CardWithIconInitiateRequestState
    extends State<CardWithIconInitiateRequest> {
  // CardWithIconInitiateRequest({Key? key})
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03),
      // left: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        elevation: 10,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreateBloodRequest(admin : true)))
          },
          // print('Card tapped.');
          child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.85, // determines the size of the card
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: AlignmentDirectional(-1, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: widget.color,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional(1, 0),
                    padding: EdgeInsets.fromLTRB(
                        0, 0, MediaQuery.of(context).size.width * 0.05, 0),
                    child: Icon(
                      widget.symbol,
                      color: widget.color,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                  //
                ],
              )),
        ),
      ),
    );
    // InfoCard(title: "Use my Current Location", onMoreTap: null)
  }
}

class CardWithIconActiveRequest extends StatelessWidget {
  // final String heading;
  @override
  final String text;
  final IconData symbol;
  final Color color;
  // final Function? newLocation;
  // final Size preferredSize;
  CardWithIconActiveRequest(
      {required this.text,
      required this.symbol,
      required this.color,
      // required this.newLocation,
      Key? key})
      : super(key: key);
  // CardWithIconInitiateViewRequest({Key? key})
  //     // : preferredSize = const Size.fromHeight(56.0),
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03),
      // left: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        elevation: 10,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => activeRequests(admin: true)))
          },
          // print('Card tapped.');
          child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.85, // determines the size of the card
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: AlignmentDirectional(-1, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional(1, 0),
                    padding: EdgeInsets.fromLTRB(
                        0, 0, MediaQuery.of(context).size.width * 0.05, 0),
                    child: Icon(
                      symbol,
                      color: color,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                  //
                ],
              )),
        ),
      ),
    );
    // InfoCard(title: "Use my Current Location", onMoreTap: null)
  }
}

class CardWithIconResolvedRequest extends StatelessWidget {
  // final String heading;
  @override
  final String text;
  final IconData symbol;
  final Color color;
  // final Function? newLocation;
  // final Size preferredSize;
  CardWithIconResolvedRequest(
      {required this.text,
      required this.symbol,
      required this.color,
      // required this.newLocation,
      Key? key})
      : super(key: key);
  // CardWithIconInitiateViewRequest({Key? key})
  //     // : preferredSize = const Size.fromHeight(56.0),
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03),
      // left: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        elevation: 10,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => adminResolvedRequests(key: key))),
          // print('Card tapped.');
          child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.85, // determines the size of the card
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: AlignmentDirectional(-1, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional(1, 0),
                    padding: EdgeInsets.fromLTRB(
                        0, 0, MediaQuery.of(context).size.width * 0.05, 0),
                    child: Icon(
                      symbol,
                      color: color,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                  //
                ],
              )),
        ),
      ),
    );
    // InfoCard(title: "Use my Current Location", onMoreTap: null)
  }
}

class CardwithIconAddDonor extends StatelessWidget {
  // final String heading;
  @override
  final String text;
  final IconData symbol;
  final Color color;
  // final Function? newLocation;
  // final Size preferredSize;
  CardwithIconAddDonor(
      {required this.text,
      required this.symbol,
      required this.color,
      // required this.newLocation,
      Key? key})
      : super(key: key);
  // CardWithIconInitiateViewRequest({Key? key})
  //     // : preferredSize = const Size.fromHeight(56.0),
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03),
      // left: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        elevation: 10,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => addDonor(key: key))),
          // print('Card tapped.');
          child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.85, // determines the size of the card
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: AlignmentDirectional(-1, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional(1, 0),
                    padding: EdgeInsets.fromLTRB(
                        0, 0, MediaQuery.of(context).size.width * 0.05, 0),
                    child: Icon(
                      symbol,
                      color: color,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                  //
                ],
              )),
        ),
      ),
    );
    // InfoCard(title: "Use my Current Location", onMoreTap: null)
  }
}

class CardWithIconPendingRequest extends StatelessWidget {
  // final String heading;
  @override
  final String text;
  final IconData symbol;
  final Color color;
  // final Function? newLocation;
  // final Size preferredSize;
  CardWithIconPendingRequest(
      {required this.text,
      required this.symbol,
      required this.color,
      // required this.newLocation,
      Key? key})
      : super(key: key);
  // CardWithIconInitiateViewRequest({Key? key})
  //     // : preferredSize = const Size.fromHeight(56.0),
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03),
      // left: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        elevation: 10,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => pendingRequests(key: key))),
          // print('Card tapped.');
          child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.85, // determines the size of the card
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: AlignmentDirectional(-1, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional(1, 0),
                    padding: EdgeInsets.fromLTRB(
                        0, 0, MediaQuery.of(context).size.width * 0.05, 0),
                    child: Icon(
                      symbol,
                      color: color,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                  //
                ],
              )),
        ),
      ),
    );
    // InfoCard(title: "Use my Current Location", onMoreTap: null)
  }
}
