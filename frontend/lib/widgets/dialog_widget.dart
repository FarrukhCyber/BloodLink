// import 'package:flutter/material.dart';

// class CustomDialogWidget extends StatelessWidget {
//   @override
//   Widget showDialog(context: context, builder: builder,)

//   void showCustomDialog(BuildContext context) => showDialog(
//         context: context,
//         barrierDismissible: false,
//         child: Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 12),
//                 Text(
//                   'This is a Custom Dialog',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   'You get more customisation freedom in this type of dialogs',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 SizedBox(height: 12),
//                 ElevatedButton(
//                   child: Text('Close'),
//                   onPressed: () => Navigator.of(context).pop(),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
// }