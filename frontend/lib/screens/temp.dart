// InputFieldWithLabel(
//               inputController: TextEditingController(),
//               hintText: "Required",
//               labelText: "Attendant Name"),




// class InputFieldWithLabel extends StatelessWidget {
//   final TextEditingController inputController;
//   final String hintText;
//   final Color primaryColor;
//   final String labelText;

//   const InputFieldWithLabel(
//       {Key? key,
//       required this.inputController,
//       required this.hintText,
//       required this.labelText,
//       this.primaryColor = const Color(0xffde2c2c)})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.85,
//       // height: MediaQuery.of(context).size.height * 0.5,
//       // height: 50,
//       decoration: BoxDecoration(boxShadow: [
//         BoxShadow(
//             offset: const Offset(12, 26),
//             blurRadius: 50,
//             spreadRadius: 0,
//             color: Colors.grey.withOpacity(.1)),
//       ]),
//       // padding: const EdgeInsets.all(right: 20, left: 20, top: 10, bottom: 10),
//       margin: EdgeInsets.fromLTRB(
//           0, MediaQuery.of(context).size.height * 0.05, 0, 0),
//       child: TextField(
//         controller: inputController,
//         onChanged: (value) {
//           //Do something with value
//         },
//         keyboardType: TextInputType.name,
//         style:
//             const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
//         decoration: InputDecoration(
//           labelText: labelText,
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           filled: true,
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
//           fillColor: Colors.transparent,
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
//           border: UnderlineInputBorder(
//             borderSide:
//                 BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: primaryColor, width: 2.0),
//           ),
//           errorBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.red, width: 2.0),
//           ),
//           enabledBorder: UnderlineInputBorder(
//             borderSide:
//                 BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
//           ),
//         ),
//       ),
//     );
//   }
// }