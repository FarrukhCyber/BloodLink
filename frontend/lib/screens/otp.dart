import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bloodlink/screens/signup.dart';

class Otp extends StatefulWidget {
  FirebaseAuth authen;
  String verify;
  String phoneNo;
  Otp(
      {Key? key,
      required this.authen,
      required this.verify,
      required this.phoneNo})
      : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpDigit1 = TextEditingController();
  TextEditingController otpDigit2 = TextEditingController();
  TextEditingController otpDigit3 = TextEditingController();
  TextEditingController otpDigit4 = TextEditingController();
  TextEditingController otpDigit5 = TextEditingController();
  TextEditingController otpDigit6 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 229, 229, 229),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 229, 229, 229),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/illustration-3.png',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 229, 229, 229),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textFieldOTP(
                              first: true, last: false, control: otpDigit1),
                          _textFieldOTP(
                              first: false, last: false, control: otpDigit2),
                          _textFieldOTP(
                              first: false, last: false, control: otpDigit3),
                          _textFieldOTP(
                              first: false, last: false, control: otpDigit4),
                          _textFieldOTP(
                              first: false, last: false, control: otpDigit5),
                          _textFieldOTP(
                              first: false, last: true, control: otpDigit6),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            verifyOTP();
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 193, 0, 0)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Verify',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Didn't you receive any code?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 18,
                ),
                TextButton(
                  child: Text(
                    "Resend New Code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 193, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    loginWithPhone();
                    otpDigit1.clear();
                    otpDigit2.clear();
                    otpDigit3.clear();
                    otpDigit4.clear();
                    otpDigit5.clear();
                    otpDigit6.clear();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({bool? first, last, control}) {
    return Container(
      height: 40,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: control,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2, color: Color.fromARGB(255, 193, 0, 0)),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verify,
        smsCode: otpDigit1.text +
            otpDigit2.text +
            otpDigit3.text +
            otpDigit4.text +
            otpDigit5.text +
            otpDigit6.text);

    try {
      await widget.authen.signInWithCredential(credential).then((value) {
        print("Phone Number Verified");
        Fluttertoast.showToast(
            msg: "Verification Sucessful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 193, 0, 0),
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => signup(phoneNo: widget.phoneNo)));
      });
    } catch (error) {
      Fluttertoast.showToast(
          msg: "Invalid OTP",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 193, 0, 0),
          textColor: Colors.white,
          fontSize: 16.0);
      otpDigit1.clear();
      otpDigit2.clear();
      otpDigit3.clear();
      otpDigit4.clear();
      otpDigit5.clear();
      otpDigit6.clear();
    }
  }

  void loginWithPhone() async {
    widget.authen.verifyPhoneNumber(
      phoneNumber: widget.phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await widget.authen.signInWithCredential(credential).then((value) {
          print("Your phone number is verified successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        widget.verify = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
