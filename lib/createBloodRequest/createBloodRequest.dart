import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// var bloodGroups = [
//   'A Positive (A+)',
//   'A Negative (A-)',
//   'B Positive (B+)',
//   'B Negative (B-)',
//   'AB Positive (AB+)',
//   'AB Negative (AB-)',
//   'O Positive (O+)',
//   'O Negative (O-)'
// ];
var items = [
  'Choose a Blood Group',
  'A Positive (A+)',
  'A Negative (A-)',
  'B Positive (B+)',
  'B Negative (B-)',
  'AB Positive (AB+)',
  'AB Negative (AB-)',
  'O Positive (O+)',
  'O Negative (O-)'
];
String dropDownValue = "Choose a Blood Group";

class CreateBloodRequest extends StatelessWidget {
  const CreateBloodRequest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: <Widget>[
          AppBarFb2(),
          TopBarFb3(
              title: "Initiate a Request",
              upperTitle:
                  "Please provide the required \n information to initiate a \n blood request"),
          InputFieldWithLabel(
              inputController: TextEditingController(),
              hintText: "Required",
              labelText: "Attendant Name"),
          InputFieldWithLabel(
              inputController: TextEditingController(),
              hintText: "Required",
              labelText: "Attendant Phone Number"),
          DropDownMenu(),
          getDate(title: "Please select a date"),
          getTime()
        ],
      ),
    );
  }
}

class TopBarFb3 extends StatelessWidget {
  final String title;
  final String upperTitle;
  TopBarFb3({required this.title, required this.upperTitle, Key? key})
      : super(key: key);
  final primaryColor = Color.fromARGB(255, 222, 44, 44);
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
                      fontSize: 20,
                      fontWeight: FontWeight.normal)))
        ],
      ),
      // ),
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
    const primaryColor = Color(0xffde2c2c);
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
        onPressed: () {},
      ),
    );
  }
}

class InputFieldWithLabel extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final Color primaryColor;
  final String labelText;

  const InputFieldWithLabel(
      {Key? key,
      required this.inputController,
      required this.hintText,
      required this.labelText,
      this.primaryColor = const Color(0xffde2c2c)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }
}

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        margin: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height * 0.03, 0, 0),
        child: DropdownButton(
          isExpanded: true,
          value: dropDownValue,
          icon: Icon(Icons.keyboard_arrow_down),
          items: items.map((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue = newValue!;
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
          Text("${selectedDate.toLocal()}".split(' ')[0]),
          SizedBox(
            height: 0,
          ),
          RaisedButton(
            onPressed: () => _selectDate(context),
            child: Text('Please select date on which blood is required'),
          ),
        ],
      ),
    );
  }
}

class getTime extends StatefulWidget {
  @override
  _getTimeState createState() {
    return _getTimeState();
  }
}

class _getTimeState extends State<getTime> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.03, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Text("Please select time by which blood is requried"),
            ),
            Text("${_selectedTime.hour}:${_selectedTime.minute}"),
          ],
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? obtainedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (obtainedTime != null && obtainedTime != _selectedTime) {
      setState(() {
        _selectedTime = obtainedTime;
      });
    }
  }
}