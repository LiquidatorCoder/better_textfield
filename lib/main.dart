import 'package:better_textfield/controllers/magnifier_controller.dart';
import 'package:better_textfield/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Basic App for Textfield demonstration
void main() {
  runApp(
    ChangeNotifierProvider<MagnifierController>(
      create: (context) => MagnifierController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Better Textfield',
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.robotoMonoTextTheme(),
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
