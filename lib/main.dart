import 'package:better_textfield/views/home_page.dart';
import 'package:flutter/material.dart';

// Basic App for Textfield demonstration
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Better Textfield',
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
      ),
      themeMode: ThemeMode.dark,
      home: HomePage(), // Home page of app
    );
  }
}
