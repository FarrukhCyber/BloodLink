import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:bloodlink/screens/registerDonor.dart';
import 'package:bloodlink/screens/networkHandler.dart';
import 'package:http/http.dart' as http;

bool diabetesSelection = false;
bool plasmaSelection = false;
bool diseaseSelect = false;
bool vaccinatedSelect = false;
DateTime dateSelection = DateTime.now();

class registerDonorContinued extends StatefulWidget {
  String bloodGroup;
  String gender;
  String contact;
  String region;
  registerDonorContinued(
      {Key? key,
      required this.bloodGroup,
      required this.gender,
      required this.contact,
      required this.region})
      : super(key: key);

  @override
  State<registerDonorContinued> createState() => _registerDonorContinuedState();
}

class _registerDonorContinuedState extends State<registerDonorContinued> {
  @override
  NetworkHandler networkHandler = NetworkHandler();
  final listDropdown = <String>['Choose', 'Yes', 'No'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppBarFb2(context),
          TopBarFb3(context, "Donor Registeration"),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  "Please provide these details to register as donor.",
                  style: TextStyle(
                    fontSize: 14,
                    //fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  'Are you diabetic?',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.left,
                ),
                //SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                DropDownMenu(
                    item: listDropdown,
                    dropDownValue: "Choose",
                    selection: "diabetes"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text(
                  "Do you have any Blood Disorder?",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.left,
                ),
                //SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                DropDownMenu(
                    item: listDropdown,
                    dropDownValue: "Choose",
                    selection: "disease"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text(
                  "Will you donate plasma too?",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.left,
                ),
                //SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                DropDownMenu(
                    item: listDropdown,
                    dropDownValue: "Choose",
                    selection: "plasma"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text(
                  "Are you vaccinated?",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.left,
                ),
                //SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                DropDownMenu(
                    item: listDropdown,
                    dropDownValue: "Choose",
                    selection: "vaccine"),
                getDate(title: "Please select a date"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                NextButton("Regsiter", 0.8)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget TopBarFb3(BuildContext context, upperTitle) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 222, 44, 44),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))),
      // gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
      // child: Padding(
      //   padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(title,
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(
          //         color: Colors.white70,
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold)),
          Center(
              child: Text(upperTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal)))
        ],
      ),
      // ),
    );
  }

  @override
  Widget AppBarFb2(BuildContext context) {
    const accentColor = Color(0xffffffff);

    return AppBar(
      centerTitle: true,
      title: const Text("BloodLink", style: TextStyle(color: Colors.white)),
      backgroundColor: Color.fromARGB(255, 222, 44, 44),
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
        onPressed: () {},
      ),
    );
  }

  @override
  Widget InputFieldWithLabel(
      BuildContext context, hintText, labelText, inputController) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      // height: MediaQuery.of(context).size.height * 0.5,
      // height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      // padding: const EdgeInsets.all(right: 20, left: 20, top: 10, bottom: 10),
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.05, 0, 0),
      child: TextField(
        controller: inputController,
        onChanged: (value) {
          //Do something with value
        },
        keyboardType: TextInputType.name,
        style:
            const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 222, 44, 44).withOpacity(.1),
                width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 222, 44, 44), width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 222, 44, 44).withOpacity(.1),
                width: 2.0),
          ),
        ),
      ),
    );
  }

  Widget NextButton(label, pad) {
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
        onPressed: () async {
          print(widget.bloodGroup);
          print(widget.gender);
          print(widget.contact);
          print(widget.region);
          print(vaccinatedSelect);
          print(diseaseSelect);
          print(plasmaSelection);
          print(diabetesSelection);
          print(dateSelection);
            Map<String, dynamic> res = {
              'user_contact_num': widget.contact,
              "blood_group": widget.bloodGroup,
              "diabetes": diseaseSelect,
              "blood_disease": diseaseSelect,
              "vaccinated": vaccinatedSelect,
              "last_donated": dateSelection.toString(),
              "region": widget.region,
              "gender": widget.gender,
              "plasma": plasmaSelection
            };
            var res1 = "03364984545";
            var url1 = "http://localhost:8080/my_requests/";
            /*final responseRegister =
                await networkHandler.get('/my_requests', res);
            print(responseRegister);
            final http.Response response = await http.get(Uri.parse(url1), headers: {
              "Content-type": "application/json",
              "user_contact_num": res1
            });
            print(response.body);*/
            var responseRegister =
                await networkHandler.post('/register_donor', res);
            if (responseRegister.statusCode == 200 ||
                responseRegister.statusCode == 201) {
              print('successful');
            } else {
              print('unsucessful');
            }
        },
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    );
  }
}

class DropDownMenu extends StatefulWidget {
  var item;
  String dropDownValue;
  String selection;
  DropDownMenu(
      {Key? key,
      required this.item,
      required this.dropDownValue,
      required this.selection})
      : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        margin: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height * 0.01, 0, 0),
        child: DropdownButton(
          value: widget.dropDownValue,
          icon: Icon(Icons.keyboard_arrow_down),
          items: widget.item.map<DropdownMenuItem<String>>((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget.dropDownValue = newValue!;
              if (widget.selection == 'vaccine') {
                vaccinatedSelect = newValue == 'Yes' ? true : false;
              } else if (widget.selection == 'disease') {
                diseaseSelect = newValue == 'Yes' ? true : false;
              } else if (widget.selection == 'plasma') {
                plasmaSelection = newValue == 'Yes' ? true : false;
              } else if (widget.selection == 'diabetes') {
                diabetesSelection = newValue == 'Yes' ? true : false;
              }
            });
          },
        ));
  }
}

class getDate extends StatefulWidget {
  getDate({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<getDate> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Color.fromARGB(255, 222, 44, 44),
            onPrimary: Colors.white,
            surface: Color.fromARGB(255, 222, 44, 44),
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateSelection = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.03, 0, 0),
      child: Column(
        children: <Widget>[
          Row(children: [
            Text("When did you donate blood last time?",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              width: 10,
            ),
            Text(
              "${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(
                color: Color.fromARGB(255, 193, 0, 0),
                decoration: TextDecoration.underline,
              ),
            ),
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          ElevatedButton(
            //padding: EdgeInsets.all(1.0),
            //olor: Color.fromARGB(255, 193, 0, 0),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 193, 0, 0)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ))),
            onPressed: () => _selectDate(context),
            child: Text(
              "Select Date",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
