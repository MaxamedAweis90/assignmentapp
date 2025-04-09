// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   final name = 'Mohamed Aweis';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'LEARNING FLUTTER',
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color.fromARGB(255, 182, 213, 23), Color(0xFF6266FF)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Center(
//             child: ShaderMask(
//               shaderCallback:
//                   (bounds) => LinearGradient(
//                     colors: [
//                       const Color.fromARGB(255, 37, 30, 29),
//                       const Color.fromARGB(255, 237, 241, 239),
//                     ],
//                   ).createShader(bounds),
//               child: Text(
//                 'My Name is $name',
//                 style: TextStyle(color: Colors.white, fontSize: 25),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:assignmentapp/pages/Start.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignments',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Startpage(),
    );
  }
}
