// import 'package:flutter/material.dart';

// import 'package:xo_game/model/text_color_classic.dart';
// import 'package:xo_game/model/text_color_new.dart'; // Replace with the actual import for your new mode page

// class PlayerPage extends StatefulWidget {
//   final String mode; // Add a mode parameter
//   const PlayerPage({Key? key, required this.mode}) : super(key: key);
//   @override
//   _PlayerPageState createState() => _PlayerPageState();
// }

// class _PlayerPageState extends State<PlayerPage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('${widget.mode} Mode'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigate to Classic Mode
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => TextColorClassicScreen()),
//                   );
//                 },
//                 child: const Text('Classic Mode'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigate to New Mode
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => TextColorNewScreen()),
//                   );
//                 },
//                 child: const Text('New Mode'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
