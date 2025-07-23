import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,//Remove debug banner
      title: 'Flutter Demo',
      home: Scaffold(
        body: Center(
          child: Text('Hello there..!! ', selectionColor: Colors.cyanAccent,),
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
