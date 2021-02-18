import 'package:flutter/material.dart';
import 'package:resfulAPI/TodoScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      title: "",
      home: TodoScreen(),
    );
    return materialApp;
  }
}
